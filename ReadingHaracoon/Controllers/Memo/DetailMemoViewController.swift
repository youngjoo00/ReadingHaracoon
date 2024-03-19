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
    
    weak var delegate: PassResultMessageDelegate?
    
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
        
        configureTapGesture()
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

        showCustomAlert(title: "메모를 저장한다쿤!", message: "제목은 꼭 입력해야 한다쿤!", actionTitle: "저장") {
            self.viewModel.inputSaveMemo.value = (title, content, nil)
        }
    }    
    
    @objc func didUpdateButtonTapped() {
        let title = mainView.titleTextField.text
        let content = mainView.contentTextView.text

        showCustomAlert(title: "메모를 수정한다쿤?", message: "제목은 꼭 입력해야 한다쿤!", actionTitle: "수정") {
            self.viewModel.inputUpdateMemo.value = (title, content, nil)
        }
    }
    
    @objc func didDeleteButtonTapped() {
        
        showCustomAlert(title: "메모를 삭제한다쿤?", message: nil, actionTitle: "삭제") {
            self.viewModel.inputDeleteMemo.value = ()
        }
    }
    
    private func bindViewModel() {
        
        viewModel.outputDataBaseReslutMessage.bindOnChanged { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let message):
                let message = message
                self.delegate?.resultMessageReceived(message: message)
                self.navigationController?.popViewController(animated: true)
            case .fail(let message):
                self.showToast(message: message)
            }
        }
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardDisMiss))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func keyboardDisMiss() {
        keyboardEndEditing()
    }
}
