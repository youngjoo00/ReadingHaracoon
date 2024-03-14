//
//  SearchViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import Foundation

final class SearchViewModel {
    
    // input
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var searchBarTextDidBeginEditingTrigger: Observable<Void?> = Observable(nil)
    
    // output
    var outputRecommendList: Observable<[[RecommendItem]]> = Observable(Array(repeating: [RecommendItem](), count: RecommendSection.allCases.count))
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    var isLoading = Observable(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bindOnChanged { [weak self] _ in
            guard let self else { return }
            self.getRecommend()
        }

    }
    
    func numberOfItems(_ tag: Int) -> Int {
        return outputRecommendList.value[tag].count
    }
}



extension SearchViewModel {
    
    private func getRecommend() {
        isLoading.value = true
    
        let group = DispatchGroup()
        
        let section = RecommendSection.allCases
        var tempList = Array(repeating: [RecommendItem](), count: section.count)
        
        for i in 0..<section.count {
            group.enter()
            AladinAPIManager.shared.callRequest(type: Recommend.self, api: .recommend(queryType: section[i].rawValue)) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let data):
                    tempList[i] = data.item
                case .failure(let failure):
                    self.outputNetworkErrorMessage.value = failure.rawValue
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.outputRecommendList.value = tempList
            self.isLoading.value = false
        }
        
    }
    
}
