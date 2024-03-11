//
//  StorageBookViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import Foundation

final class StorageBookViewModel {
    
    let repository = BookRepository()
    
    // input
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    var searchBarTextDidBeginEditingTrigger: Observable<Void?> = Observable(nil)
    var inputSearchBarTextDidChange: Observable<String> = Observable("")
    
    // output
    var outputBookList: Observable<[Book]> = Observable([])
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    var isLoading = Observable(false)

    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppearTrigger.bindOnChanged { [weak self] _ in
            guard let self else { return }
            self.loadInitialBookList()
        }
        
        inputSearchBarTextDidChange.bindOnChanged { [weak self] text in
            guard let self else { return }
            self.filterBookList(text)
        }
    }
    
}


extension StorageBookViewModel {
    private func loadInitialBookList() {
        let bookList = repository.fetchBookArrayList()
        outputBookList.value = bookList
    }
    
    private func filterBookList(_ searchText: String) {
        let bookList = repository.fetchBookArrayList()
        
        if searchText.isEmpty {
            outputBookList.value = bookList
            return
        } else {
            // 서치텍스트에 포함되는 book 의 제목 및 저자
            let filterBookList = bookList.filter { book in
                book.title.contains(searchText) || book.author.contains(searchText)
            }
            
            outputBookList.value = filterBookList
        }
    }
}
