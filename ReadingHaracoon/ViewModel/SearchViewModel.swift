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
    var inputSearchBarText: Observable<String?> = Observable(nil)
    
    // output
    var outputRecommendList: Observable<[Recommend_Item]> = Observable([])
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    var outputTransition: Observable<String?> = Observable(nil)
    var isLoading = Observable(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidAppearTrigger.bind { [weak self] _ in
            self?.getRecommend()
        }
        
        inputSearchBarText.bind { [weak self] searchText in
            guard let searchText, let self else { return }
            print(searchText)
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
