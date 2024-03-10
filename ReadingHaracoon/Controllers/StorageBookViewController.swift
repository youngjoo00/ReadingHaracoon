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
    
    var list: [Book] = []
    
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


extension StorageBookViewController {
    
    func configureView() {
        navigationItem.titleView = mainView.navigationTitle
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    func bindViewModel() {
        viewModel.outputBookList.bind { [weak self] list in
            guard let self else { return }
            self.list = list
            self.mainView.collectionView.reloadData()
        }
    }
}

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
    
    
}
