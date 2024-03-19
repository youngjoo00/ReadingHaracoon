//
//  SearchDetailViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import UIKit
import SVProgressHUD
import Kingfisher

final class DetailSearchViewController: BaseViewController {
    
    let mainView = DetailSearchView()
    let viewModel = DetailSearchViewModel()
    
    var list: [SearchItem] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindViewModel()
        configureTapGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.inputViewDidAppearTrigger.value = ()
    }
}

extension DetailSearchViewController {
    private func configureView() {
        navigationItem.titleView = mainView.navigationTitle
        
        mainView.searchBar.delegate = self
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.prefetchDataSource = self
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardDisMiss))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func keyboardDisMiss() {
        keyboardEndEditing()
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind { isLoding in
            if isLoding {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
        
        viewModel.outputSearchList.bind { [weak self] value in
            self?.list = value
            self?.mainView.collectionView.reloadData()
        }
        
        viewModel.outputNetworkErrorMessage.bind { [weak self] message in
            guard let message, let self else { return }
            
            self.showCustomAlert(title: "오류!", message: message, actionTitle: "재시도") {
                self.searchBarSearchButtonClicked(self.mainView.searchBar)
            }
        }
        
        viewModel.didSelectItemAtBookDetailTransition.bind { [weak self] isbn in
            guard let isbn, let self else { return }
            let vc = DetailBookViewController()
            vc.viewModel.inputISBN.value = isbn
            vc.viewModel.viewMode.value = .search
            self.transition(viewController: vc, style: .push)
        }
        
        viewModel.outputScrollMoveToTopTrigger.bindOnChanged { [weak self] _ in
            guard let self else { return }
            self.mainView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
}


// MARK: - CollectionView
extension DetailSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailSearchCollectionViewCell.identifier, for: indexPath) as? DetailSearchCollectionViewCell else { return UICollectionViewCell() }
        
        let item = list[indexPath.item]
        cell.updateView(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAtBookDetailTransition.value = list[indexPath.item].isbn13
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        viewModel.inputPreFetchItemsAt.value = indexPaths
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
    }
}



// MARK: - SearchBar
extension DetailSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchBarText.value = searchBar.text
        keyboardEndEditing()
    }
}
