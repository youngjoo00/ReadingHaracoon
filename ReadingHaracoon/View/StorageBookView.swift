//
//  FavoriteView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import UIKit
import Then

final class StorageBookView: BaseView {
    
    let navigationTitle = UILabel().then {
        $0.text = "보관한 책"
    }
    
    let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.placeholder = "보관한 책을 검색해보세요"
    }
    
    let stateSegmentControl = UISegmentedControl()
    
    let filterButton = UIButton().then {
        var configuration = UIButton.Configuration.gray()
        configuration.title = "필터링"
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .black
        $0.configuration = configuration
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.register(StorageBookCollectionViewCell.self, forCellWithReuseIdentifier: StorageBookCollectionViewCell.identifier)
        $0.backgroundColor = .clear
    }
    
    override func configureHierarchy() {
        [
            searchBar,
            collectionView
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
}

extension StorageBookView {
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
    
        let cellWidth = (UIScreen.main.bounds.width - (spacing * 4)) / 3
        let cellHeight = cellWidth * 1.4
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        return layout
    }
    
}
