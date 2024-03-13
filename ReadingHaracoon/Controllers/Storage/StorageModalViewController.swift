//
//  StorageModalViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/13/24.
//

import UIKit

final class StorageModalViewController: BaseViewController {
    
    private let mainView = StorageModalView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
}


extension StorageModalViewController {
    
    private func configureView() {
        mainView.closeButton.addTarget(self, action: #selector(didCloseButtonTapped), for: .touchUpInside)
    }
    
    @objc func didCloseButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
