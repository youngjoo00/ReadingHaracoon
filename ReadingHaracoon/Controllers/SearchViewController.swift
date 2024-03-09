//
//  SearchViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import UIKit
import SVProgressHUD

final class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    let viewModel = SearchViewModel()
    
    var list: [RecommendItem] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.inputViewDidAppearTrigger.value = ()
    }
}


// MARK: - Custom Func
extension SearchViewController {
    private func configureView() {
        navigationItem.titleView = mainView.navigationTitle
        
        mainView.searchBar.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind { isLoding in
            if isLoding {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
        
        viewModel.outputRecommendList.bindOnChanged { [weak self] value in
            self?.list = value
            print("베스트셀러 리스트 불러왔음")
        }
        
        viewModel.outputNetworkErrorMessage.bind { [weak self] message in
            guard let message, let self else { return }
            
            self.showAlert(title: "오류!", message: message, btnTitle: "재시도") {
                print("")
            }
        }
        
        viewModel.searchBarTextDidBeginEditingTrigger.bindOnChanged { [weak self] value in
            guard let self else { return }
            let vc = SearchDetailViewController()
            vc.mainView.searchBar.becomeFirstResponder()
            self.transition(viewController: vc, style: .push)
        }
    }
}

// MARK: - UISearchBar
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.searchBarTextDidBeginEditingTrigger.value = ()
    }
}
