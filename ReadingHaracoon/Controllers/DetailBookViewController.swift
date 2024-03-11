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

extension DetailBookViewController {
    private func configureView() {
        navigationItem.titleView = mainView.navigationTitle
        
        let rightBtnItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(didRightBarFavortieButtonItemTapped))
        
        navigationItem.rightBarButtonItem = rightBtnItem
        mainView.linkButton.addTarget(self, action: #selector(didLinkButtonTapped), for: .touchUpInside)
    }
    
    @objc func didRightBarFavortieButtonItemTapped() {
        viewModel.inputDidRightBarFavortieButtonItemTappedTrigger.value = ()
    }
    
    @objc func didLinkButtonTapped() {
        let vc = AladinWebViewController()
        vc.viewModel.inputLink.value = viewModel.outputBookData.value?.link
        transition(viewController: vc, style: .push)
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind { isLoding in
            if isLoding {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
        
        viewModel.outputBookData.bindOnChanged { [weak self] data in
            guard let self, let data else { return }
            self.mainView.updateView(.InquiryItem(data))
        }
        
        viewModel.outputNetworkErrorMessage.bind { [weak self] message in
            guard let message, let self else { return }
            
            self.showAlert(title: "오류!", message: message, btnTitle: "재시도") {
                print("")
            }
        }
        
        viewModel.outputIsFavortie.bind { [weak self] bool in
            guard let self else { return }
            self.navigationItem.rightBarButtonItem?.image = bool ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        }
    }
    
}
