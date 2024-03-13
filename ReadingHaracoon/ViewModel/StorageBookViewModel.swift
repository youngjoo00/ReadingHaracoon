//
//  StorageBookViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import Foundation

final class StorageBookViewModel {
    
    let repository = BookRepository()
    
    // input
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    var searchBarTextDidBeginEditingTrigger: Observable<Void?> = Observable(nil)
    var inputSearchBarTextDidChange: Observable<String> = Observable("")
    var inputSelectedFilter: Observable<(Int, FilterContent)> = Observable((0, .regDate))
    
    // output
    var outputBookList: Observable<[Book]> = Observable([])
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    var isLoading = Observable(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppearTrigger.bindOnChanged { [weak self] _ in
            guard let self else { return }
            self.loadInitialBookList()
        }
        
        inputSearchBarTextDidChange.bindOnChanged { [weak self] text in
            guard let self else { return }
            self.filterSearchBarTextBookList(text)
        }
        
        inputSelectedFilter.bindOnChanged { [weak self] sort, content in
            guard let self else { return }
            self.filterSelectBookList(sort, content)
        }
    }
    
}


extension StorageBookViewModel {
    private func loadInitialBookList() {
        let bookList = repository.fetchBookArrayList()
        outputBookList.value = bookList
    }
    
    private func filterSearchBarTextBookList(_ searchText: String) {
        let bookList = repository.fetchBookArrayList()
        
        if searchText.isEmpty {
            outputBookList.value = bookList
            return
        } else {
            // 서치텍스트에 포함되는 book 의 제목 및 저자
            let filterBookList = bookList.filter { book in
                book.title.contains(searchText) || book.author.contains(searchText)
            }
            
            outputBookList.value = filterBookList
        }
    }
    
    // 임시 필터링
    // sort -> 0: 내림차순, 1: 오름차순
    // content -> 0: 등록일, 1: 쪽수
    private func filterSelectBookList(_ sort: Int, _ content: FilterContent) {
        let bookList = repository.fetchBookArrayList()

        switch content {
        case .regDate:
            let filterRegDateBookList = self.sortedRegDate(bookList, sort)
            return outputBookList.value = filterRegDateBookList
        case .page:
            let filterPageBookList = self.sortedPageDate(bookList, sort)
            return outputBookList.value = filterPageBookList
        }
    }
    
    private func sortedRegDate(_ bookList: [Book], _ sort: Int) -> [Book] {
        var filterBookList: [Book] = []
        
        if sort == 0 {
            filterBookList = bookList.sorted {
                $0.regDate > $1.regDate
            }
        } else {
            filterBookList = bookList.sorted {
                $0.regDate < $1.regDate
            }
        }

        return filterBookList
    }
    
    private func sortedPageDate(_ bookList: [Book], _ sort: Int) -> [Book] {
        var filterBookList: [Book] = []
        
        if sort == 0 {
            filterBookList = bookList.sorted {
                $0.page > $1.page
            }
        } else {
            filterBookList = bookList.sorted {
                $0.page < $1.page
            }
        }
        
        return filterBookList
    }
}
