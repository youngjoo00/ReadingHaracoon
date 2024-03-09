//
//  BookDetailViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/9/24.
//

import Foundation

final class BookDetailViewModel {
    
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    var inputISBN: Observable<String?> = Observable(nil)

    var isLoading = Observable(false)
    
    var outputNetworkErrorMessage: Observable<String?> = Observable(nil)
    var outputBookData: Observable<InquiryItem?> = Observable(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppearTrigger.bind { [weak self] _ in
            guard let self, let isbn = inputISBN.value else { return }
            self.getInquiry(isbn)
        }
    }
}

extension BookDetailViewModel {
    
    private func getInquiry(_ isbnID: String) {
        isLoading.value = true
        AladdinAPIManager.shared.callRequest(type: Inquiry.self, api: .inquiry(id: isbnID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                self.outputBookData.value = data.item.first
            case .failure(let failure):
                self.outputNetworkErrorMessage.value = failure.rawValue
            }
            self.isLoading.value = false
        }
    }
    
}
