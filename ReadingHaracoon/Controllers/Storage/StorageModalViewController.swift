//
//  StorageModalViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/13/24.
//

import UIKit

final class StorageModalViewController: BaseViewController {
    
    private let mainView = StorageModalView()
    private let viewModel = DetailBookViewModel()
    private var selectedTag = 0

    var selectedBookClosure: ((Int) -> Void)?

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
        mainView.toReadButton.addTarget(self, action: #selector(didSelectButtonTapped), for: .touchUpInside)
        mainView.readingButton.addTarget(self, action: #selector(didSelectButtonTapped), for: .touchUpInside)
        mainView.readButton.addTarget(self, action: #selector(didSelectButtonTapped), for: .touchUpInside)
        mainView.storageButton.addTarget(self, action: #selector(didStorageButtonTapped), for: .touchUpInside)
    }
    
    @objc func didCloseButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didSelectButtonTapped(_ sender: UIButton) {
        mainView.updateButton(sender)
        selectedTag = sender.tag
    }
    
    @objc func didStorageButtonTapped() {
        selectedBookClosure?(selectedTag)
        dismiss(animated: true)
    }
}
