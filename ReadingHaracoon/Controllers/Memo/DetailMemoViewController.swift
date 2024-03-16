//
//  WriteMemoViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/15/24.
//

import UIKit

final class DetailMemoViewController: BaseViewController {
    
    let mainView = DetailMemoView()
    let viewModel = DetailMemoViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindViewModel()
    }
    
}


// MARK: - Custom Func
extension DetailMemoViewController {
    
    enum DetailMemoViewMode {
        case create
        case read
    }

    private func configureView() {
        
        switch viewModel.viewMode {
        case .create:
            mainView.saveButton.isHidden = false
            mainView.buttonStackView.isHidden = true
            mainView.saveButton.addTarget(self, action: #selector(didSaveButtonTapped), for: .touchUpInside)
        case .read:
            mainView.saveButton.isHidden = true
            mainView.buttonStackView.isHidden = false
            mainView.updateButton.addTarget(self, action: #selector(didUpdateButtonTapped), for: .touchUpInside)
            mainView.deleteButton.addTarget(self, action: #selector(didDeleteButtonTapped), for: .touchUpInside)
        }
        
    }
    
    @objc func didSaveButtonTapped() {
        let title = mainView.titleTextField.text
        let content = mainView.contentTextView.text

        viewModel.inputSaveMemo.value = (title, content, nil)
    }
    
    @objc func didUpdateButtonTapped() {
        let title = mainView.titleTextField.text
        let content = mainView.contentTextView.text

        viewModel.inputUpdateMemo.value = (title, content, nil)
    }
    
    @objc func didDeleteButtonTapped() {
        viewModel.inputDeleteMemo.value = ()
    }
    
    private func bindViewModel() {
        
        viewModel.outputDataBaseReslutMessage.bindOnChanged { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let message):
                let message = message
                self.showToast(message: message)
                // 여기서 pop 하면서 나갈때 딜리게이트에 메세지 값을 넣어줘야할듯?
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.navigationController?.popViewController(animated: true)
                }
            case .fail(let message):
                self.showToast(message: message)
            }
        }
    }
}
