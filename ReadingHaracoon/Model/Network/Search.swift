//
//  Search.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

struct Search: Decodable {
    let item: [SearchItem]
}

struct SearchItem: Decodable {
    let title: String
    let description: String
    let author: String
    let isbn13: String
    let cover: String
    let publisher: String
}
