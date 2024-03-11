//
//  Inquiry.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

struct Inquiry: Decodable {
    let item: [InquiryItem]
}

struct InquiryItem: Decodable {
    let title: String
    let link: String
    let author: String
    let description: String
    let isbn13: String
    let cover: String
    let categoryName: String
    let publisher: String
    let subInfo: SubInfo
}

struct SubInfo: Decodable {
    let itemPage: Int
}
