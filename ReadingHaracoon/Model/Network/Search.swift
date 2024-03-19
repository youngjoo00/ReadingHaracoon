//
//  Search.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

struct Search: Decodable {
    let totalResults: Int
    let startIndex: Int
    let item: [SearchItem]
    
    enum CodingKeys: CodingKey {
        case totalResults
        case startIndex
        case item
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalResults = try container.decode(Int.self, forKey: .totalResults)
        self.startIndex = try container.decode(Int.self, forKey: .startIndex)
        self.item = try container.decode([SearchItem].self, forKey: .item)
    }
}

struct SearchItem: Decodable {
    let title: String
    let description: String
    let author: String
    let isbn13: String
    let cover: String
    let publisher: String
}
