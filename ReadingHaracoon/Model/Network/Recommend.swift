//
//  Recommend.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

struct Recommend: Decodable {
    let item: [RecommendItem]
}

struct RecommendItem: Decodable {
    let title: String
    let description: String
    let isbn13: String
    let cover: String
    let bestRank: Int?
}
