//
//  BookDetailController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/9/24.
//

protocol BookStatusDelegate: AnyObject {
}

import UIKit
import SVProgressHUD

final class DetailBookViewController: BaseViewController {
    
    let mainView = DetailBookView()
    let viewModel = DetailBookViewModel()
    
    private var customTransitioningDelegate = CustomTransitioningDelegate(.center)
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.inputViewWillAppearTrigger.value = ()
    }
}


// MARK: - Custom Func
extension DetailBookViewController {
    
    private func configureView() {
        navigationItem.titleView = mainView.navigationTitle
        
        let rightBtnItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(didRightBarFavortieButtonItemTapped))
        
        navigationItem.rightBarButtonItem = rightBtnItem
        mainView.linkButton.addTarget(self, action: #selector(didLinkButtonTapped), for: .touchUpInside)
        mainView.bookStatusButton.addTarget(self, action: #selector(didBookStatusButtonTapped), for: .touchUpInside)
        mainView.memoButton.addTarget(self, action: #selector(didMemoButtonTapped), for: .touchUpInside)
        mainView.timerButton.addTarget(self, action: #selector(didTimerButtonTapped), for: .touchUpInside)
    }
    
    @objc func didRightBarFavortieButtonItemTapped() {
        if viewModel.outputIsFavortie.value {
            showAlert(title: "이 책을 삭제하시겠습니까?", message: "이 책과 관련된 데이터가 모두 삭제됩니다.", btnTitle: "삭제") {
                self.viewModel.inputDidRightBarFavortieButtonItemTappedTrigger.value = ()
            }
        } else {
            // 화면 중앙에 책을 어떻게 저장할지에 대한 모달 등장
            presentStorageModalViewController(false)
        }
    }
    
    private func presentStorageModalViewController(_ isFavorite: Bool) {
        let storageModalViewController = DetailBookModalViewController()
        storageModalViewController.modalPresentationStyle = .custom
        storageModalViewController.transitioningDelegate = customTransitioningDelegate
        storageModalViewController.isFavorite = isFavorite
        storageModalViewController.selectedBookClosure = { [weak self] tag in
            guard let self else { return }
            self.viewModel.inputBookStatus.value = tag
            if isFavorite {
                self.viewModel.inputUpdateItemTrigger.value = ()
            } else {
                self.viewModel.inputDidRightBarFavortieButtonItemTappedTrigger.value = ()
            }
        }
        present(storageModalViewController, animated: true, completion: nil)
    }
    
    @objc func didLinkButtonTapped() {
        guard let mode = viewModel.viewMode.value else { return }
        switch mode {
        case .storage:
            let vc = AladinWebViewController()
            vc.viewModel.inputLink.value = viewModel.RealmBookData.value?.link
            transition(viewController: vc, style: .push)
        case .search:
            let vc = AladinWebViewController()
            vc.viewModel.inputLink.value = viewModel.outputAPIBookData.value?.link
            transition(viewController: vc, style: .push)
        }
    }
    
    // 책 상태 업데이트
    @objc func didBookStatusButtonTapped() {
        presentStorageModalViewController(true)
    }
    
    @objc func didMemoButtonTapped() {
        let vc = MemoViewController()
        vc.viewModel.inputISBN.value = viewModel.isbn
        transition(viewController: vc, style: .push)
    }
    
    @objc func didTimerButtonTapped() {
        
    }
}


// MARK: - bindViewModel
extension DetailBookViewController {
    private func bindViewModel() {
        viewModel.isLoading.bind { isLoding in
            if isLoding {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
        
        viewModel.outputAPIBookData.bindOnChanged { [weak self] data in
            guard let self, let data else { return }
            self.mainView.updateView(.InquiryItem(data))
        }
        
        viewModel.RealmBookData.bind { [weak self] data in
            guard let self, let data else { return }
            self.mainView.updateView(.Book(data))
        }
        
        viewModel.outputNetworkErrorMessage.bind { [weak self] message in
            guard let message, let self else { return }
            
            self.showAlert(title: "오류!", message: message, btnTitle: "재시도") {
                print("")
            }
        }
        
        viewModel.outputIsFavortie.bind { [weak self] isFavorite in
            guard let self else { return }
            
            self.navigationItem.rightBarButtonItem?.image = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            mainView.updateBottomView(isFavorite)
        }
        
        viewModel.outputCreateDataResult.bindOnChanged { [weak self] message in
            guard let self else { return }
            
            self.showToast(message: message)
        }
        
        viewModel.outputDeleteDataResult.bindOnChanged { [weak self] message in
            guard let self else { return }
            
            self.showToast(message: message)
            navigationItem.rightBarButtonItem?.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        viewModel.outputUpdateDataResult.bindOnChanged { [weak self] message in
            guard let self else { return }
            
            self.showToast(message: message)
        }
    }
}
