//
//  BookDetailViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/9/24.
//

import Foundation

final class DetailBookViewModel {
    
    let repository = BookRepository()
    
    // input
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    var inputISBN: Observable<String?> = Observable(nil)
    var inputDidRightBarFavortieButtonItemTappedTrigger: Observable<Void?> = Observable(nil)
    var inputBookStatus: Observable<Int?> = Observable(nil)
    var inputUpdateItemTrigger: Observable<Void?> = Observable(nil)
    
    // output
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    var outputAPIBookData: Observable<InquiryItem?> = Observable(nil)
    var outputIsFavortie = Observable(false)
    var outputCreateDataResult = Observable("")
    var outputUpdateDataResult = Observable("")
    var outputDeleteDataResult = Observable("")
    
    var isLoading = Observable(false)
    var RealmBookData: Observable<Book?> = Observable(nil)
    var viewMode: Observable<TransitionDetailBook?> = Observable(nil)
    var isbn = ""
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppearTrigger.bind { [weak self] _ in
            guard let self, let mode = viewMode.value else  { return }
            switch mode {
            case .storage:
                guard let book = RealmBookData.value else { return }
                self.isbn = book.isbn
                self.updateFavoriteStatus(self.isbn)
            case .search:
                guard let isbn = inputISBN.value else { return }
                self.isbn = isbn
                self.getInquiry(self.isbn)
                self.updateFavoriteStatus(self.isbn)
            }
        }
        
        inputDidRightBarFavortieButtonItemTappedTrigger.bindOnChanged { [weak self] _ in
            guard let self, let mode = viewMode.value else { return }
            switch mode {
            case .storage:
                self.deleteBookItem(isbn)
            case .search:
                outputIsFavortie.value ? self.deleteBookItem(isbn) : self.createBookItem()
            }
        }
        
        inputUpdateItemTrigger.bindOnChanged { [weak self] _ in
            guard let self, let bookStatus = inputBookStatus.value, let mode = viewMode.value else { return }
            self.updateBookStatus(isbn, bookStatus: bookStatus)
        }
    }
}

extension DetailBookViewModel {
    
    private func getInquiry(_ isbnID: String) {
        isLoading.value = true
        AladinAPIManager.shared.callRequest(type: Inquiry.self, api: .inquiry(id: isbnID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                self.outputAPIBookData.value = data.item.first
            case .failure(let failure):
                self.outputNetworkErrorMessage.value = failure.rawValue
            }
            self.isLoading.value = false
        }
    }
    
    private func updateFavoriteStatus(_ isbn: String) {
        let isFavorite = self.repository.checkedItem(isbn)
        self.outputIsFavortie.value = isFavorite
    }
    
    private func createBookItem() {
        guard let data = self.outputAPIBookData.value, let bookStatus = self.inputBookStatus.value else { return }
        
        let item = Book(title: data.title, link: data.link, author: data.author, descript: data.description, isbn: data.isbn13, cover: data.cover, categoryName: data.categoryName, publisher: data.publisher, regDate: Date(), bookStatus: bookStatus, page: data.subInfo.itemPage, totalReadingTime: 0)
        
        do {
            try repository.createBookItem(item)
            updateFavoriteStatus(item.isbn)
            self.outputCreateDataResult.value = "책을 저장했다쿤!"
        } catch {
            self.outputCreateDataResult.value = "책 저장에 실패했다쿤.."
        }
        
        
    }
    
    private func deleteBookItem(_ isbn: String) {
        guard let item = repository.fetchBookItem(isbn) else { return }
        
        do {
            try repository.deleteItem(item)
            updateFavoriteStatus(isbn)
            self.outputDeleteDataResult.value = "책을 삭제했다쿤!"
        } catch {
            self.outputDeleteDataResult.value = "책 삭제에 실패했다쿤.."
        }
    }
    
    private func updateBookStatus(_ isbn: String, bookStatus: Int) {
        do {
            try repository.updateBookStatus(isbn, newStatus: bookStatus)
            self.outputUpdateDataResult.value = "책 상태 수정을 성공했다쿤!"
        } catch BookError.bookNotFound {
            self.outputUpdateDataResult.value = "책을 찾을 수 없다쿤.."
        } catch {
            self.outputUpdateDataResult.value = "알 수 없는 오류로 인해 수정에 실패했다쿤.."
        }
    }
}
