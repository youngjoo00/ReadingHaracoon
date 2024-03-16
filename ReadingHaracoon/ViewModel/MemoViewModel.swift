//
//  MemoViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/15/24.
//

import Foundation

final class MemoViewModel {
    
    let bookRepository = BookRepository()
    var repository: MemoRepository?
    var bookData: Book?
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputViewWillApeearTrigger: Observable<Void?> = Observable(nil)
    var inputISBN = Observable("")

    var outputMemoList: Observable<[Memo]> = Observable([])


    init() {
        
        do {
            repository = try MemoRepository()
        } catch {
            print("realm 초기화 실패: ", error)
        }
        
        transform()
    }
    
    func transform() {
        inputViewDidLoadTrigger.bindOnChanged { [weak self] _ in
            guard let self else { return }
            self.getBookData(inputISBN.value)
        }
        
        inputViewWillApeearTrigger.bind { [weak self] _ in
            guard let self, let book = bookData else { return }
            self.getMemoList(book)
        }
    }
    
}

extension MemoViewModel {
    
    private func getBookData(_ isbn: String) {
        guard let book = bookRepository.fetchBookItem(isbn) else { return }
        self.bookData = book
    }
    
    private func getMemoList(_ book: Book) {
        self.outputMemoList.value = Array(book.memoList)
    }
}
