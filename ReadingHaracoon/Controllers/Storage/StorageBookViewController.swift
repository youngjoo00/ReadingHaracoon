//
//  FavoriteViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import UIKit

final class StorageBookViewController: BaseViewController {
    
    let mainView = StorageBookView()
    let viewModel = StorageBookViewModel()
    
    private var list: [Book] = []
    
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
extension StorageBookViewController {
    
    private func configureView() {
        navigationItem.titleView = mainView.navigationTitle
        
        mainView.searchBar.delegate = self
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.outputBookList.bind { [weak self] list in
            guard let self else { return }
            self.list = list
            self.mainView.collectionView.reloadData()
        }
    }
}


// MARK: - CollectionView
extension StorageBookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageBookCollectionViewCell.identifier, for: indexPath) as? StorageBookCollectionViewCell else { return UICollectionViewCell() }
        
        let data = list[indexPath.item]
        cell.updateView(data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailStorageBookViewController()
        vc.viewModel.bookData.value = list[indexPath.item]
        vc.hidesBottomBarWhenPushed = true
        transition(viewController: vc, style: .push)
    }
}


// MARK: - SearchBar
extension StorageBookViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.inputSearchBarTextDidChange.value = searchText
    }
}
