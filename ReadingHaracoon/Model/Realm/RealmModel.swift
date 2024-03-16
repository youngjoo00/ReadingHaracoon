//
//  RealmModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import RealmSwift
import Foundation

class Book: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String // 책 이름
    @Persisted var memoList: List<Memo> // 메모 리스트
    @Persisted var statsList: List<Stats> // 통게 리스트
    @Persisted var link: String // 알라딘 링크
    @Persisted var author: String // 저자
    @Persisted var descript: String // 책 설명
    @Persisted var isbn: String // isbn13
    @Persisted var cover: String // 커버 이미지 URL
    @Persisted var categoryName: String // 카테고리명
    @Persisted var publisher: String // 출판사
    @Persisted var regDate: Date // 책 등록일
    @Persisted var endDate: Date? // 다 읽은 책 날짜
    @Persisted var bookStatus: Int // 책 상태 (읽을 책, 읽고 있는 책, 다 읽은 책)
    @Persisted var page: Int // 책 페이지
    @Persisted var totalReadingTime: Int // 총 읽은 시간 (초 단위)
    
    convenience init(title: String, link: String, author: String, descript: String, isbn: String, cover: String, categoryName: String, publisher: String, regDate: Date, endDate: Date? = nil, bookStatus: Int, page: Int, totalReadingTime: Int) {
        self.init()
        self.title = title
        self.memoList = memoList
        self.statsList = statsList
        self.link = link
        self.author = author
        self.descript = descript
        self.isbn = isbn
        self.cover = cover
        self.categoryName = categoryName
        self.publisher = publisher
        self.regDate = regDate
        self.endDate = endDate
        self.bookStatus = bookStatus
        self.page = page
        self.totalReadingTime = totalReadingTime
    }
}

class Memo: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String // 메모 제목
    @Persisted var content: String? // 메모 내용
    @Persisted var photo: String? // 메모에 넣을 사진
    @Persisted var regDate: Date // 메모 등록일

    @Persisted(originProperty: "memoList") var superTable: LinkingObjects<Book>
    
    convenience init(title: String, content: String? = nil, photo: String? = nil, regDate: Date) {
        self.init()
        self.title = title
        self.content = content
        self.photo = photo
        self.regDate = regDate
    }
}

class Stats: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var readingTime: Double? // 읽은 시간
    @Persisted var readingDate: Date // 읽은 날짜

    @Persisted(originProperty: "statsList") var superTable: LinkingObjects<Book>
    
    convenience init(readingTime: Double? = nil, readingDate: Date, superTable: LinkingObjects<Book>) {
        self.init()
        self.readingTime = readingTime
        self.readingDate = readingDate
        self.superTable = superTable
    }
}
