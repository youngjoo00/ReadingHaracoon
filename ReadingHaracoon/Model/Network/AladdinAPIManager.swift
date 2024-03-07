//
//  AladdinAPIManager.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import Alamofire

final class AladdinAPIManager {
    
    static let shared = AladdinAPIManager()
    
    private init() { }
    
    func callRequest<T: Decodable>(type: T.Type, api: AladdinAPI, completionHandler: @escaping (_ result: Result<T, ErrorStatus>) -> Void) {
        AF.request(api.endPoint,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString))
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let fail):
                switch fail {
                case .responseValidationFailed:
                    print("응답코드 에러", fail)
                    completionHandler(.failure(.invalidResponse))
                case .responseSerializationFailed(let reason):
                    if case .inputDataNilOrZeroLength = reason {
                        print("데이터 없음", fail)
                        completionHandler(.failure(.noData))
                    } else {
                        print("디코딩 실패", fail)
                        completionHandler(.failure(.invalidData))
                    }
                default:
                    print("통신 에러", fail)
                    completionHandler(.failure(.failedRequest))
                }
            }
        }
    }
    
}
