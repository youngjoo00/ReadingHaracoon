//
//  SearchDetailViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/8/24.
//

import Foundation

final class DetailSearchViewModel {
    
    // input
    var inputViewDidAppearTrigger: Observable<Void?> = Observable(nil)
    var inputSearchBarText: Observable<String?> = Observable(nil)
    var inputPreFetchItemsAt: Observable<[IndexPath]> = Observable([])
    var didSelectItemAtBookDetailTransition: Observable<String?> = Observable(nil)
    
    // output
    var outputSearchList: Observable<[SearchItem]> = Observable([])
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    var outputTransition: Observable<String?> = Observable(nil)
    var isLoading = Observable(false)
    var outputScrollMoveToTopTrigger: Observable<Void?> = Observable(nil)
    var start = 0
    var totalResult = 0
    
    init() {
        transform()
    }
    
    private func transform() {
        inputSearchBarText.bind { [weak self] searchText in
            guard let searchText, let self else { return }
            start = 1
            self.getSearch(searchText, start: start)
        }
        
        inputPreFetchItemsAt.bindOnChanged { [weak self] indexPaths in
            guard let self else { return }
            
            let list = self.outputSearchList.value
            for item in indexPaths {
                if list.count - 10 == item.item && list.count < totalResult {
                    guard let searchText = inputSearchBarText.value else { return }
                    start += 1
                    getSearch(searchText, start: start)
                }
            }
        }
        
    }
}



extension DetailSearchViewModel {
    
    private func getSearch(_ searchText: String, start: Int) {
        isLoading.value = true
        AladinAPIManager.shared.callRequest(type: Search.self, api: .search(query: searchText, start: start)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                if start == 1 {
                    self.outputSearchList.value = data.item
                    self.totalResult = data.totalResults
                    if data.totalResults != 0 {
                        self.outputScrollMoveToTopTrigger.value = ()
                    }
                } else {
                    self.outputSearchList.value.append(contentsOf: data.item)
                }
            case .failure(let failure):
                self.outputNetworkErrorMessage.value = failure.rawValue
            }
            self.isLoading.value = false
        }
    }
    
    
}