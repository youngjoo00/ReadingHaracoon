//
//  BookDetailViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/9/24.
//

import Foundation

final class BookDetailViewModel {
    
    let repository = BookRepository()
    
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    var inputISBN: Observable<String?> = Observable(nil)
    var inputDidRightBarFavortieButtonItemTappedTrigger: Observable<Void?> = Observable(nil)
    
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    var outputBookData: Observable<InquiryItem?> = Observable(nil)
    var outputIsFavortie = Observable(false)
    var isLoading = Observable(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppearTrigger.bind { [weak self] _ in
            guard let self, let isbn = inputISBN.value else { return }
            self.getInquiry(isbn)
            self.updateFavoriteStatus(isbn)
        }
        
        inputDidRightBarFavortieButtonItemTappedTrigger.bindOnChanged { [weak self] _ in
            guard let self else { return }
            if outputIsFavortie.value {
                self.deleteBookItem()
            } else {
                self.createBookItem()
            }
            
        }
    }
}

extension BookDetailViewModel {
    
    private func getInquiry(_ isbnID: String) {
        isLoading.value = true
        AladinAPIManager.shared.callRequest(type: Inquiry.self, api: .inquiry(id: isbnID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                self.outputBookData.value = data.item.first
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
        guard let data = self.outputBookData.value else { return }
        
        let item = Book(title: data.title, link: data.link, author: data.author, descript: data.description, isbn: data.isbn13, cover: data.cover, categoryName: data.categoryName, publisher: data.publisher, regDate: Date(), bookStatus: 0, page: data.subInfo.itemPage, totalReadingTime: 0)
        
        repository.createItem(item)
        updateFavoriteStatus(item.isbn)
    }
    
    private func deleteBookItem() {
        guard let isbn = inputISBN.value, let item = repository.fetchBookItem(isbn) else { return }
        
        do {
            try repository.deleteItem(item)
            updateFavoriteStatus(isbn)
        } catch {
            print(error)
        }
    }
}
