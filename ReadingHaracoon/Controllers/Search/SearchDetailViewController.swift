//
//  SearchDetailViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import UIKit
import SVProgressHUD
import Kingfisher

final class SearchDetailViewController: BaseViewController {
    
    let mainView = SearchDetailView()
    let viewModel = SearchDetailViewModel()
    
    var list: [SearchItem] = []
    
    let cellRegistration = UICollectionView.CellRegistration<SearchDetailCollectionViewCell, SearchItem> { cell, indexPath, item in
        let url = URL(string: item.cover)
        cell.bookImageView.kf.setImage(with: url)
        
        cell.titleLabel.text = item.title
        cell.authorLabel.text = item.author
        cell.publisherLabel.text = item.publisher
        cell.descriptionLabel.text = item.description
    }
    
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

extension SearchDetailViewController {
    private func configureView() {
        navigationItem.titleView = mainView.navigationTitle
        
        mainView.searchBar.delegate = self
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
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
            
            self.showAlert(title: "오류!", message: message, btnTitle: "재시도") {
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
    }
}


// MARK: - CollectionView
extension SearchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAtBookDetailTransition.value = list[indexPath.item].isbn13
    }
}


// MARK: - SearchBar
extension SearchDetailViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchBarText.value = searchBar.text
        keyboardEndEditing()
    }
}
