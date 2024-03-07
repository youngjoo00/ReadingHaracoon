//
//  Recommend.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

struct Recommend: Decodable {
    let item: [Recommend_Item]
}

struct Recommend_Item: Decodable {
    let title: String
    let description: String
    let isbn13: String
    let bestRank: Int
}
