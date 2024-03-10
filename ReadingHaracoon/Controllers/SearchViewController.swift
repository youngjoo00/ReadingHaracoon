//
//  SearchViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import UIKit
import SVProgressHUD
import FSPagerView

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
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoding in
            guard self != nil else { return }
            
            if isLoding {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
        
        viewModel.outputRecommendList.bindOnChanged { [weak self] data in
            guard let self else { return }
            self.list = data
            mainView.tableView.reloadData()
        }
        
        viewModel.outputNetworkErrorMessage.bind { [weak self] message in
            guard let message, let self else { return }
            
            self.showAlert(title: "오류!", message: message, btnTitle: "재시도") {
                print(message)
            }
        }
        
        viewModel.searchBarTextDidBeginEditingTrigger.bindOnChanged { [weak self] value in
            guard let self else { return }
            let vc = SearchDetailViewController()
            vc.mainView.searchBar.becomeFirstResponder()
            vc.hidesBottomBarWhenPushed = true
            self.transition(viewController: vc, style: .push)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.pagerView.dataSource = self
        cell.pagerView.delegate = self
        cell.pagerView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}

// MARK: - FSPagerView
extension SearchViewController: FSPagerViewDelegate, FSPagerViewDataSource {

    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return viewModel.numberOfItems()
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: SearchPagerViewCell.identifier, at: index) as? SearchPagerViewCell else { return FSPagerViewCell() }
        
        let item = list[index]
        cell.updateView(item)

        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let vc = BookDetailViewController()
        vc.viewModel.inputISBN.value = list[index].isbn13
        vc.hidesBottomBarWhenPushed = true
        transition(viewController: vc, style: .push)
    }
}


// MARK: - UISearchBar
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.searchBarTextDidBeginEditingTrigger.value = ()
    }
}
