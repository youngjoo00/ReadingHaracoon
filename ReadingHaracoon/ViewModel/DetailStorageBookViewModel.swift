//
//  DetailStorageBookViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/11/24.
//

import UIKit

final class DetailStorageBookViewModel {
    
    let repository = BookRepository()
    
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    var bookData: Observable<Book?> = Observable(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppearTrigger.bind { [weak self] _ in
            guard let self, let book = bookData.value else { return }
            //self.getBook(book)
        }
    }
}

extension DetailStorageBookViewModel {

    
}
