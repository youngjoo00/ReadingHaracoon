//
//  WriteMemoViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/15/24.
//

import Foundation

enum DetailMemoViewMode {
    case create
    case read
}

final class DetailMemoViewModel {
    
    var repository: MemoRepository?
    var bookData: Book?
    var viewMode = DetailMemoViewMode.create
    var memo: Memo?
    var inputSaveMemo: Observable<(String?, String?, String?)> = Observable((nil, nil, nil))
    var inputUpdateMemo: Observable<(String?, String?, String?)> = Observable((nil, nil, nil))
    var inputDeleteMemo: Observable<Void?> = Observable(nil)
    
    var outputDataBaseReslutMessage = Observable<DatabaseResultMessage>(.success(""))
    
    init() {
        do {
            repository = try MemoRepository()
        } catch {
            print(error)
        }
        
        transform()
    }
    
    func transform() {

        inputSaveMemo.bindOnChanged { [weak self] title, content, photo in
            guard let self, let book = bookData, let title else { return }
            
            if title.isEmpty {
                self.outputDataBaseReslutMessage.value = .fail("제목을 입력하라쿤!")
            } else {
                self.createItem(book, title: title, content: content, photo: photo)
            }
        }
        
        inputUpdateMemo.bindOnChanged { [weak self] title, content, photo in
            guard let self, let title, let memo else { return }
  
            if title.isEmpty {
                self.outputDataBaseReslutMessage.value = .fail("제목을 입력하라쿤!")
            } else {
                self.updateItem(memo, title: title, content: content, photo: photo)
            }
        }
        
        inputDeleteMemo.bindOnChanged { [weak self] _ in
            guard let self, let memo else { return }
            
            self.deleteItem(memo)
//            if let memo = repository?.fetchMemoItem(memo) {
//                self.deleteItem(memo)
//            } else {
//                self.outputDataBaseReslutMessage.value = .fail("메모를 찾을 수 없다쿤..")
//            }
            
        }
    }
    
}

extension DetailMemoViewModel {
    
    private func createItem(_ book: Book, title: String, content: String?, photo: String?) {
        let memo = Memo(title: title, content: content, photo: photo, regDate: Date())

        do {
            try repository?.createMemoItem(book, memo: memo)
            self.outputDataBaseReslutMessage.value = .success("메모 저장에 성공했다쿤!")
        } catch {
            self.outputDataBaseReslutMessage.value = .fail("메모 저장에 실패했다쿤..")
        }
    }
    
    private func updateItem(_ memo: Memo, title: String, content: String?, photo: String?) {

        do {
            try repository?.updateMemoItem(item: memo, title: title, content: content, photo: photo)
            self.outputDataBaseReslutMessage.value = .success("메모 수정에 성공했다쿤!")
        } catch {
            self.outputDataBaseReslutMessage.value = .fail("메모 수정에 실패했다쿤..")
        }
    }
    
    private func deleteItem(_ memo: Memo) {

        do {
            try repository?.deleteItem(memo)
            self.outputDataBaseReslutMessage.value = .success("메모 삭제에 성공했다쿤!")
        } catch {
            self.outputDataBaseReslutMessage.value = .fail("메모 삭제에 실패했다쿤..")
        }
    }
    
}
