//
//  SearchDetailViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/8/24.
//

import Foundation

final class SearchDetailViewModel {
    
    // input
    var inputViewDidAppearTrigger: Observable<Void?> = Observable(nil)
    var inputSearchBarText: Observable<String?> = Observable(nil)
    
    var didSelectItemAtBookDetailTransition: Observable<String?> = Observable(nil)
    
    // output
    var outputSearchList: Observable<[SearchItem]> = Observable([])
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    var outputTransition: Observable<String?> = Observable(nil)
    var isLoading = Observable(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputSearchBarText.bind { [weak self] searchText in
            guard let searchText, let self else { return }
            self.getSearch(searchText)
        }
    }
}



extension SearchDetailViewModel {
    
    private func getSearch(_ searchText: String) {
        isLoading.value = true
        AladinAPIManager.shared.callRequest(type: Search.self, api: .search(query: searchText)) { [weak self] result in
            switch result {
            case .success(let data):
                self?.outputSearchList.value = data.item
            case .failure(let failure):
                self?.outputNetworkErrorMessage.value = failure.rawValue
            }
            self?.isLoading.value = false
        }
    }
    
}
