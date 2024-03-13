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
    
    // output
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    var outputAPIBookData: Observable<InquiryItem?> = Observable(nil)
    var outputIsFavortie = Observable(false)
    var outputIsPOP = Observable(false)
    
    var isLoading = Observable(false)
    var RealmBookData: Observable<Book?> = Observable(nil)
    var viewMode: Observable<TransitionDetailBook?> = Observable(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppearTrigger.bind { [weak self] _ in
            guard let self, let mode = viewMode.value else  { return }
            switch mode {
            case .storage:
                guard let book = RealmBookData.value else { return }
                self.updateFavoriteStatus(book.isbn)
            case .search:
                guard let isbn = inputISBN.value else { return }
                self.getInquiry(isbn)
                self.updateFavoriteStatus(isbn)
            }
        }
        
        inputDidRightBarFavortieButtonItemTappedTrigger.bindOnChanged { [weak self] _ in
            guard let self, let mode = viewMode.value else { return }
            switch mode {
            case .storage:
                guard let isbn = RealmBookData.value?.isbn else { return }
                self.deleteBookItem(isbn)
            case .search:
                guard let isbn = inputISBN.value else { return }
                outputIsFavortie.value ? self.deleteBookItem(isbn) : self.createBookItem()
            }
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
        guard let data = self.outputAPIBookData.value else { return }
        
        let item = Book(title: data.title, link: data.link, author: data.author, descript: data.description, isbn: data.isbn13, cover: data.cover, categoryName: data.categoryName, publisher: data.publisher, regDate: Date(), bookStatus: 0, page: data.subInfo.itemPage, totalReadingTime: 0)
        
        repository.createItem(item)
        updateFavoriteStatus(item.isbn)
        self.outputIsPOP.value = true
    }
    
    private func deleteBookItem(_ isbn: String) {
        guard let item = repository.fetchBookItem(isbn) else { return }
        
        do {
            try repository.deleteItem(item)
            updateFavoriteStatus(isbn)
            self.outputIsPOP.value = true
        } catch {
            print(error)
        }
    }
}
