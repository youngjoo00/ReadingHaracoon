//
//  StorageModalViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/13/24.
//

import UIKit

final class DetailBookModalViewController: ModalViewController {
    
    private let mainView = DetailBookModalView()
    private let viewModel = DetailBookViewModel()
    var selectedTag = 0
    var isFavorite = false
    var selectedBookClosure: ((Int) -> Void)?

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        mainView.updateButton(selectedTag)
    }
    
}


extension DetailBookModalViewController {
    
    private func configureView() {
        mainView.closeButton.addTarget(self, action: #selector(didCloseButtonTapped), for: .touchUpInside)
        mainView.toReadButton.addTarget(self, action: #selector(didSelectButtonTapped), for: .touchUpInside)
        mainView.readingButton.addTarget(self, action: #selector(didSelectButtonTapped), for: .touchUpInside)
        mainView.readButton.addTarget(self, action: #selector(didSelectButtonTapped), for: .touchUpInside)
        mainView.confirmButton.addTarget(self, action: #selector(didStorageButtonTapped), for: .touchUpInside)
        mainView.configureConfirmButton(isFavorite)
    }
    
    @objc func didCloseButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didSelectButtonTapped(_ sender: UIButton) {
        mainView.updateButton(sender.tag)
        selectedTag = sender.tag
    }
    
    @objc func didStorageButtonTapped() {
        selectedBookClosure?(selectedTag)
        dismiss(animated: true)
    }
}
