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
            let bookList = Array(self.repository.fetchBookTable())
            outputBookList.value = bookList
        }
    }
}
