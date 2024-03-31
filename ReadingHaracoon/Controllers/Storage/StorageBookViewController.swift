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
    
    let customTransitioningDelegate = CustomTransitioningDelegate(.bottom)
    
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
        mainView.searchBar.delegate = self
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.stateSegmentControl.addTarget(self, action: #selector(stateSegmentControlValueChanged(_:)), for: .valueChanged)
        mainView.filterButton.addTarget(self, action: #selector(didFilterButtonTapped), for: .touchUpInside)
        configureTapGesture()
        configureLogo()
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardDisMiss))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardDisMiss() {
        keyboardEndEditing()
    }
    
    private func bindViewModel() {
        viewModel.outputBookList.bind { [weak self] list in
            guard let self else { return }
            if list.isEmpty {
                mainView.noStorageLabel.isHidden = false
                mainView.collectionView.isHidden = true
            } else {
                mainView.noStorageLabel.isHidden = true
                mainView.collectionView.isHidden = false
                self.list = list
                self.mainView.collectionView.reloadData()
            }
            
        }
    }
    
    @objc func stateSegmentControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
        viewModel.inputStateSegmentControlChangedValue.value = selectedIndex
    }
    
    @objc func didFilterButtonTapped() {
        presentStorageModalViewController()
    }
    
    private func presentStorageModalViewController() {
        let storageModalViewController = StorageFilterModalViewController()
        storageModalViewController.modalPresentationStyle = .custom
        storageModalViewController.transitioningDelegate = customTransitioningDelegate
        storageModalViewController.selectedSegmentControl = self.viewModel.inputSelectedFilter.value.0
        storageModalViewController.selectedTag = self.viewModel.inputSelectedFilter.value.1
        
        storageModalViewController.selectedFilterClosure = { [weak self] sort, content in
            guard let self else { return }
            self.viewModel.inputSelectedFilter.value = (sort, content)
        }
        present(storageModalViewController, animated: true, completion: nil)
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
        let vc = DetailBookViewController()
        let data = list[indexPath.item]
        vc.viewModel.realmBookData.value = data
        vc.viewModel.viewMode.value = .storage
        vc.viewModel.inputBookStatus.value = data.bookStatus
        vc.hidesBottomBarWhenPushed = true
        transition(viewController: vc, style: .push)
    }
}


// MARK: - SearchBar
extension StorageBookViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.inputSearchBarTextDidChange.value = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        keyboardEndEditing()
    }
}
