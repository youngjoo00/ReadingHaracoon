//
//  SearchDetailView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/8/24.
//

import UIKit
import Then

final class DetailSearchView: BaseView {
    
    let navigationTitle = UILabel().then {
        $0.text = "검색"
    }
    
    let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.placeholder = "책을 검색해보세요"
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout()).then {
        $0.register(DetailSearchCollectionViewCell.self, forCellWithReuseIdentifier: DetailSearchCollectionViewCell.identifier)
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
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
}

// MARK: - Custom Func
extension DetailSearchView {
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = .clear
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
}
