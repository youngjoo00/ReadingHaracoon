//
//  FilterModalViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/14/24.
//

enum FilterContent: Int, CaseIterable {
    case regDate
    case page
}

import UIKit

final class StorageFilterModalViewController: ModalViewController {
    
    let mainView = StorageFilterModalView()
    var selectedSegmentControl = 0
    var selectedTag: FilterContent = .regDate
    
    var selectedFilterClosure: ((Int, FilterContent) -> Void)?

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        mainView.filterSegmentControl.selectedSegmentIndex = selectedSegmentControl
        mainView.updateView(selectedTag)
    }
    
}

extension StorageFilterModalViewController {
    
    private func configureView() {
        mainView.closeButton.addTarget(self, action: #selector(didCloseButtonTapped), for: .touchUpInside)
        mainView.storageDateButton.addTarget(self, action: #selector(didSelectButtonTapped), for: .touchUpInside)
        mainView.pageButton.addTarget(self, action: #selector(didSelectButtonTapped), for: .touchUpInside)
        mainView.storageButton.addTarget(self, action: #selector(didStorageButtonTapped), for: .touchUpInside)
    }
    
    @objc func didCloseButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didSelectButtonTapped(_ sender: UIButton) {
        guard let tag = FilterContent(rawValue: sender.tag) else { return }
        selectedTag = tag
        
        mainView.updateView(tag)
    }
    
    @objc func didStorageButtonTapped() {
        selectedFilterClosure?(mainView.filterSegmentControl.selectedSegmentIndex, selectedTag)
        dismiss(animated: true)
    }
    
}
