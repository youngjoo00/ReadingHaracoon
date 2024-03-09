//
//  AladinWebViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/10/24.
//

import Foundation

final class AladinWebViewModel {
    
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    var inputLink: Observable<String?> = Observable(nil)
    
    var outputURLRequest: Observable<URLRequest?> = Observable(nil)

    init() {
        transform()
    }
    
    func transform() {
        inputViewWillAppearTrigger.bind { [weak self] _ in
            guard let self, let link = inputLink.value else { return }
            if let url = URL(string: link) {
                self.outputURLRequest.value = URLRequest(url: url)
            }
        }
    }
    
}
