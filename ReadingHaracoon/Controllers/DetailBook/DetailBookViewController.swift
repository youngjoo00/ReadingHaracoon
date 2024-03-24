//
//  BookDetailController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/9/24.
//

import UIKit
import SVProgressHUD

final class DetailBookViewController: BaseViewController {
    
    let mainView = DetailBookView()
    let viewModel = DetailBookViewModel()
    let bookRepository = BookRepository()
    private var customTransitioningDelegate = CustomTransitioningDelegate(.bottom)
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindViewModel()
        viewModel.inputViewDidLoadTrigger.value = ()
    }
    
}


// MARK: - Custom Func
extension DetailBookViewController {
    
    private func configureView() {
        let rightBtnItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(didRightBarFavortieButtonItemTapped))
        
        navigationItem.rightBarButtonItem = rightBtnItem
        mainView.linkButton.addTarget(self, action: #selector(didLinkButtonTapped), for: .touchUpInside)
        mainView.bookStatusButton.addTarget(self, action: #selector(didBookStatusButtonTapped), for: .touchUpInside)
        mainView.memoButton.addTarget(self, action: #selector(didMemoButtonTapped), for: .touchUpInside)
        mainView.timerButton.addTarget(self, action: #selector(didTimerButtonTapped), for: .touchUpInside)
        mainView.storageButton.addTarget(self, action: #selector(didStorageButtonTapped), for: .touchUpInside)
    }
    
    @objc func didRightBarFavortieButtonItemTapped() {
        if viewModel.checkSameBookTimer() {
            showToast(message: "타이머가 진행중인 책은 삭제할 수 없다쿤!")
        } else {
            showCustomAlert(title: "이 책을 삭제한다쿤?", message: "책과 관련된 데이터가 모두 삭제된다쿤!", actionTitle: "삭제") {
                self.viewModel.inputDidRightBarFavortieButtonItemTappedTrigger.value = ()
            }
        }
        
    }
    
    @objc func didStorageButtonTapped() {
        // 화면 중앙에 책을 어떻게 저장할지에 대한 모달 등장
        presentStorageModalViewController(false)
    }
    
    private func presentStorageModalViewController(_ isFavorite: Bool) {
        let storageModalViewController = DetailBookModalViewController()
        storageModalViewController.modalPresentationStyle = .custom
        storageModalViewController.transitioningDelegate = customTransitioningDelegate
        storageModalViewController.isFavorite = isFavorite
        storageModalViewController.selectedTag = self.viewModel.inputBookStatus.value ?? 0
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
            vc.viewModel.inputLink.value = viewModel.realmBookData.value?.link
            transition(viewController: vc, style: .push)
        case .search:
            let vc = AladinWebViewController()
            vc.viewModel.inputLink.value = viewModel.outputAPIBookData.value?.link
            transition(viewController: vc, style: .push)
        }
    }
    
    // 책 상태 업데이트
    @objc func didBookStatusButtonTapped() {
        if viewModel.checkSameBookTimer() {
            showToast(message: "타이머가 진행중인 책의 상태는 변경할 수 없다쿤!")
        } else {
            presentStorageModalViewController(true)
        }
    }
    
    @objc func didMemoButtonTapped() {
        let vc = MemoViewController()
        vc.viewModel.inputISBN.value = viewModel.isbn
        transition(viewController: vc, style: .push)
    }
    
    @objc func didTimerButtonTapped() {
        guard let currentBook = viewModel.realmBookData.value else { return }
        let runningTimerBookISBN = UserDefaultsManager.shared.getRunningTimerBookISBN()
        if runningTimerBookISBN == currentBook.isbn || runningTimerBookISBN == nil {
            let vc = TimerViewController()
            vc.viewModel.bookData = viewModel.realmBookData.value
            vc.delegate = self
            showCustomModal(style: .timer, viewController: vc)
        } else {
            guard let runningTimerBook = bookRepository.fetchBookItem(runningTimerBookISBN ?? "") else { return }
            let message = "[\(runningTimerBook.title)] 타이머가 실행되고 있다쿤!"
            showToast(message: message)
        }
        
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
        
        viewModel.realmBookData.bind { [weak self] data in
            guard let self, let data else { return }
            self.mainView.updateView(.Book(data))
        }
        
        viewModel.outputNetworkErrorMessage.bind { [weak self] message in
            guard let message, let self else { return }
            
            showCustomAlert(title: "오류!", message: message, actionTitle: "재시도") {
                self.viewModel.inputViewDidLoadTrigger.value = ()
            }
        }
        
        viewModel.outputIsFavortie.bind { [weak self] isFavorite in
            guard let self else { return }
            
            if isFavorite {
                self.navigationItem.rightBarButtonItem?.isHidden = false
            } else {
                self.navigationItem.rightBarButtonItem?.isHidden = true
            }
            mainView.updateBottomView(isFavorite)
        }
        
        viewModel.outputCreateDataResult.bindOnChanged { [weak self] message in
            guard let self else { return }
            
            self.showToast(message: message)
        }
        
        viewModel.outputDeleteDataResult.bindOnChanged { [weak self] message in
            guard let self else { return }
            
            self.showToast(message: message)
            view.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        viewModel.outputUpdateDataResult.bindOnChanged { [weak self] message in
            guard let self else { return }
            
            self.showToast(message: message)
        }
        
        viewModel.inputBookStatus.bindOnChanged { [weak self] status in
            guard let self, let status else { return }
            if status == 0 {
                mainView.timerButton.isHidden = true
            } else {
                mainView.timerButton.isHidden = false
            }
        }
        
    }
}


extension DetailBookViewController: PassResultMessageDelegate {
    func resultMessageReceived(message: String) {
        showToast(message: message)
    }
}
