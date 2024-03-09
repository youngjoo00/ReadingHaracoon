//
//  SearchViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import Foundation

final class SearchViewModel {
    
    // input
    var inputViewDidAppearTrigger: Observable<Void?> = Observable(nil)
    var searchBarTextDidBeginEditingTrigger: Observable<Void?> = Observable(nil)
    
    // output
    var outputRecommendList: Observable<[RecommendItem]> = Observable([])
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    var isLoading = Observable(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidAppearTrigger.bindOnChanged { [weak self] _ in
            guard let self else { return }
            self.getRecommend()
        }

    }
    
}



extension SearchViewModel {
    
    private func getRecommend() {
        isLoading.value = true
        AladdinAPIManager.shared.callRequest(type: Recommend.self, api: .recommend(queryType: "Bestseller")) { [weak self] result in
            switch result {
            case .success(let data):
                self?.outputRecommendList.value = data.item
            case .failure(let failure):
                self?.outputNetworkErrorMessage.value = failure.rawValue
            }
            self?.isLoading.value = false
        }
    }
    
}
