//
//  DetailStorageBookViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/11/24.
//

import Foundation

import UIKit
import SVProgressHUD

final class DetailStorageBookViewController: BaseViewController {
    
    let mainView = DetailBookView()
    let viewModel = DetailStorageBookViewModel()
    
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

extension DetailStorageBookViewController {
    private func configureView() {
        navigationItem.titleView = mainView.navigationTitle
        
        let rightBtnItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(didRightBarFavortieButtonItemTapped))
        
        navigationItem.rightBarButtonItem = rightBtnItem
        mainView.linkButton.addTarget(self, action: #selector(didLinkButtonTapped), for: .touchUpInside)
    }
    
    @objc func didRightBarFavortieButtonItemTapped() {
        //detailBookViewModel.inputDidRightBarFavortieButtonItemTappedTrigger.value = ()
    }
    
    @objc func didLinkButtonTapped() {
//        let vc = AladinWebViewController()
//        vc.viewModel.inputLink.value = detailBookViewModel.outputBookData.value?.link
//        transition(viewController: vc, style: .push)
    }
    
    private func bindViewModel() {

        viewModel.bookData.bind { [weak self] data in
            guard let self, let data else { return }
            self.mainView.updateView(.Book(data))
        }
        
//        detailBookViewModel.outputIsFavortie.bind { [weak self] bool in
//            guard let self else { return }
//            self.navigationItem.rightBarButtonItem?.image = bool ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
//        }
    }
    
}
