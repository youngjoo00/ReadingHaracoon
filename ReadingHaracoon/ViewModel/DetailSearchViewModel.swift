//
//  SearchDetailViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/8/24.
//

import Foundation

final class DetailSearchViewModel {
    
    private var isFetching = false
    
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
            guard let searchText, let self = self else { return }
            self.start = 1
            self.isFetching = true
            self.getSearch(searchText, start: self.start)
        }
        
        inputPreFetchItemsAt.bindOnChanged { [weak self] indexPaths in
            guard let self = self, !self.isFetching else { return }
            
            let list = self.outputSearchList.value
            if let maxItem = indexPaths.map({ $0.item }).max(), list.count - 1 <= maxItem && list.count < 200 {
                self.isFetching = true
                guard let searchText = self.inputSearchBarText.value else { return }
                self.start += 1
                self.getSearch(searchText, start: self.start)
            }
        }
    }
}

extension DetailSearchViewModel {
    
    private func getSearch(_ searchText: String, start: Int) {
        isLoading.value = true
        
        AladinAPIManager.shared.callRequest(type: Search.self, api: .search(query: searchText, start: start)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if self.start == 1 {
                    self.outputSearchList.value = data.item.filter { !$0.isbn13.isEmpty }
                    self.totalResult = data.totalResults
                    if data.totalResults != 0 {
                        self.outputScrollMoveToTopTrigger.value = ()
                    }
                } else {
                    self.outputSearchList.value.append(contentsOf: data.item.filter { !$0.isbn13.isEmpty })
                }
            case .failure(let failure):
                self.outputNetworkErrorMessage.value = failure.rawValue
            }
            self.isFetching = false
            self.isLoading.value = false
        }
    }
}
