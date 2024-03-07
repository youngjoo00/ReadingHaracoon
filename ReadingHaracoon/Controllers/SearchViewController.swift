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
    
    var list: [Recommend_Item] = []
    
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
        
        viewModel.outputRecommendList.bind { value in
            self.list = value
            print("베스트셀러 리스트 불러왔음")
        }
        
        viewModel.outputNetworkErrorMessage.bind { message in
            guard let message else { return }
            
            self.showAlert(title: "오류!", message: message, btnTitle: "재시도") {
                self.searchBarSearchButtonClicked(self.mainView.searchBar)
            }
        }
        
//        viewModel.outputTransition.bind { id in
//            guard let id else { return }
//            let vc = ChartViewController()
//            vc.viewModel.inputCoinID.value = id
//            self.transition(viewController: vc, style: .push)
//        }
    }
}

// MARK: - UISearchBar
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchBarText.value = searchBar.text
    }
}
