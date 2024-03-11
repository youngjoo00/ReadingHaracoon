//
//  RecommendQueryType.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/12/24.
//

enum RecommendSection: String, CaseIterable {
    case Bestseller
    case ItemNewSpecial
    case ItemNewAll
    
    var RecommendString: String {
        switch self {
        case .Bestseller:
            return "베스트셀러"
        case .ItemNewSpecial:
            return "주목할 만한 신간"
        case .ItemNewAll:
            return "신간"
        }
    }
}
