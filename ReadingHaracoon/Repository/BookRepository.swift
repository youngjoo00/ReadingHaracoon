//
//  BookRepository.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/10/24.
//

import Foundation
import RealmSwift

enum BookError: String, Error {
    case bookNotFound = "책을 찾을 수 없습니다."
}

final class BookRepository {
    
    let realm = try! Realm()
    
    func createBookItem<T: Object>(_ item: T) throws {
        do {
            try realm.write {
                realm.add(item)
                print(realm.configuration.fileURL!)
            }
        } catch {
            print("Book 생성 실패")
            throw error
        }
    }
    
    func checkedItem(_ isbn: String) -> Bool {
        let data = fetchBookTable().filter("isbn == %@", isbn)
        return !data.isEmpty
    }
  
    func fetchBookItem(_ isbn: String) -> Book? {
        return fetchBookTable().filter("isbn == %@", isbn).first
    }
    
    func fetchBookTable() -> Results<Book> {
        return realm.objects(Book.self)
    }
    
    func fetchBookArrayList() -> [Book] {
        return Array(fetchBookTable())
    }
    
//    func fetchTable<T: Object>() -> Results<T> {
//        return realm.objects(T.self)
//    }
    
    func updateBookStatus(_ isbn: String, newStatus: Int) throws {
        guard let book = fetchBookItem(isbn) else { throw BookError.bookNotFound }
        
        do {
            try realm.write {
                book.bookStatus = newStatus
                print("업데이트 성공")
            }
        } catch {
            print("업데이트 실패")
            throw error
        }
    }
    
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
