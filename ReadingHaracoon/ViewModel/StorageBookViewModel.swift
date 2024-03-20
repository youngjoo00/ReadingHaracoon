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
    var inputStateSegmentControlChangedValue = Observable(0)
    
    // output
    var outputBookList: Observable<[Book]> = Observable([])
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    var isLoading = Observable(false)
    
    var stateBook: [Book] = []
    var filterdBook: [Book] = []
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppearTrigger.bindOnChanged { [weak self] _ in
            guard let self else { return }
            self.filterBook(inputStateSegmentControlChangedValue.value)
        }
        
        inputSearchBarTextDidChange.bindOnChanged { [weak self] text in
            guard let self else { return }
            self.filterSearchBarTextBookList(text)
        }
        
        inputStateSegmentControlChangedValue.bindOnChanged { [weak self] value in
            guard let self else { return }
            self.filterBook(value)
        }
        
        inputSelectedFilter.bindOnChanged { [weak self] sort, content in
            guard let self else { return }
            
            self.filterSelectBookList(stateBook, sort, content)
        }
    }
    
}


extension StorageBookViewModel {
    
    private func filterBook(_ value: Int) {
        if value == 0 {
            stateBook = getBookList()
        } else {
            stateBook = getBookList().filter { $0.bookStatus + 1 == value }
        }
        
        let sort = inputSelectedFilter.value.0
        let content = inputSelectedFilter.value.1
        self.filterSelectBookList(stateBook, sort, content)
    }
    
    // 필터링 된 상태에서 가져와야할듯
    private func getBookList() -> [Book] {
        let bookList = repository.fetchBookArrayList()
        return bookList
    }
    
    private func filterSearchBarTextBookList(_ searchText: String) {
        let bookList = filterdBook
        
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
    
    // sort -> 0: 내림차순, 1: 오름차순
    // content -> 0: 등록일, 1: 쪽수
    private func filterSelectBookList(_ stateBook: [Book], _ sort: Int, _ content: FilterContent) {
        switch content {
        case .regDate:
            let filterRegDateBookList = self.sortedRegDate(stateBook, sort)
            filterdBook = filterRegDateBookList
            return outputBookList.value = filterRegDateBookList
        case .page:
            let filterPageBookList = self.sortedPageDate(stateBook, sort)
            filterdBook = filterPageBookList
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
