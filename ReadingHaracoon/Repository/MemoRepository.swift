//
//  MemoRepository.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/15/24.
//

import RealmSwift

final class MemoRepository {
    
    var realm: Realm
    
    init() throws {
        realm = try Realm()
    }
    
    func createMemoItem(_ book: Book, memo: Memo) throws {
        do {
            try realm.write {
                book.memoList.append(memo)
                print(realm.configuration.fileURL!)
            }
        } catch {
            print("Memo 생성 실패")
            throw error
        }
    }
    
    func fetchMemoTable(_ isbn: String) -> List<Memo>? {
        let book = realm.objects(Book.self).filter("isbn == %@", isbn).first
        return book?.memoList
    }
    
    func updateMemoItem(item: Memo, title: String, content: String?, photo: String?) throws {
        do {
            try realm.write {
                item.title = title
                item.content = content
                item.photo = photo
                realm.add(item, update: .modified)
            }
        } catch {
            print("Failed to update item: \(error)")
            throw error
        }
    }
    
//    func fetchMemoItem(_ id: String) -> Memo? {
//        return realm.objects(Memo.self).filter("id == %@", id).first
//    }
    
    func deleteItem<T: Object>(_ item: T) throws {
        do {
            try realm.write {
                realm.delete(item)
                print("삭제 성공")
            }
        } catch {
            print("삭제 실패")
            throw error
        }
    }
}
