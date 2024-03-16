//
//  AladdinAPI.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import Alamofire
import Foundation

enum AladinAPI {
    case recommend(queryType: String)
    case search(query: String, startIndex: Int)
    case inquiry(id: String)
    
    static let baseURL = "http://www.aladin.co.kr/ttb/api/"
    
    static let baseParameter: Parameters = [
        "ttbkey": APIKey.ttbkey,
        "Version": "20131101",
        "Output": "JS",
        "Cover": "Big"
    ]
    
    var endPoint: URL {
        switch self {
        case .recommend:
            return URL(string: AladinAPI.baseURL + "ItemList.aspx")!
        case .search:
            return URL(string: AladinAPI.baseURL + "ItemSearch.aspx")!
        case .inquiry:
            return URL(string: AladinAPI.baseURL + "ItemLookUp.aspx")!
        }
    }
    
    var parameter: Parameters {
        var parameters = AladinAPI.baseParameter
        switch self {
        case .recommend(let queryType):
            parameters["QueryType"] = queryType
            parameters["SearchTarget"] = "Book"
            return parameters
        case .search(let query, let startIndex):
            parameters["Query"] = query
            parameters["itemPage"] = "true"
            parameters["MaxResults"] = "50"
            parameters["startIndex"] = startIndex
            return parameters
        case .inquiry(let id):
            parameters["itemId"] = id
            parameters["itemPage"] = "true"
            parameters["ItemIdType"] = "ISBN13"
            return parameters
        }
    }
    
}
