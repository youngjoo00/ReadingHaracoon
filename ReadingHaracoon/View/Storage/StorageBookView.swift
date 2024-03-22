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
    
    let stateSegmentControl = UISegmentedControl().then {
        $0.insertSegment(withTitle: "전체", at: 0, animated: false)
        $0.insertSegment(withTitle: "읽을 책", at: 1, animated: false)
        $0.insertSegment(withTitle: "읽고 있는 책", at: 2, animated: false)
        $0.insertSegment(withTitle: "읽은 책", at: 3, animated: false)
        $0.selectedSegmentIndex = 0
        $0.setTitleTextAttributes([.foregroundColor: UIColor.point], for: .selected)
        $0.setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
        $0.apportionsSegmentWidthsByContent = true
    }
    
    let filterButton = UIButton().then {
        var configuration = UIButton.Configuration.gray()
        configuration.title = "필터링"
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .point
        $0.configuration = configuration
    }
    
    let noStorageLabel = BasePaddingLabel().then {
        $0.text = "검색화면에서 책을 검색하고 저장하라쿤!"
        $0.backgroundColor = .white
        $0.font = .boldSystemFont(ofSize: 20)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.textColor = .point
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.preferredMaxLayoutWidth = 200
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.register(StorageBookCollectionViewCell.self, forCellWithReuseIdentifier: StorageBookCollectionViewCell.identifier)
        $0.backgroundColor = .clear
    }
        
    override func configureHierarchy() {
        [
            searchBar,
            stateSegmentControl,
            filterButton,
            noStorageLabel,
            collectionView
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        stateSegmentControl.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.height.equalTo(filterButton)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(filterButton.snp.leading).offset(-10)
        }
        
        filterButton.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.trailing.equalTo(searchBar).offset(-10)
        }
        
        noStorageLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(filterButton.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
}

extension StorageBookView {
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
    
        let cellWidth = (UIScreen.main.bounds.width - (spacing * 4.1)) / 3
        let cellHeight = cellWidth * 1.6
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        return layout
    }
    
}
