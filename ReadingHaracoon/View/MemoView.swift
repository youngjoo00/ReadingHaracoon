//
//  MemoView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/15/24.
//

import UIKit
import Then

enum MemoSection {
    case memo
}

final class MemoView: BaseView {
    
    var dataSource: UICollectionViewDiffableDataSource<MemoSection, Memo>?
    var memoList: [Memo] = []
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    let writeButton = UIButton().then {
        var configuration = UIButton.Configuration.gray()
        configuration.title = "메모 작성"
        configuration.image = UIImage(systemName: "pencil")
        configuration.baseForegroundColor = .point
        configuration.baseBackgroundColor = .white
        configuration.imagePadding = 10
        $0.configuration = configuration
    }
    
    override func configureHierarchy() {
        [
            collectionView,
            writeButton
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        writeButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        collectionView.backgroundColor = .background
        configureDataSource()
        updateSnapShot()
    }
}


// MARK: - Custom Func
extension MemoView {
    
    private func createLayout() -> UICollectionViewLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureDataSource() {
        
        let cellRegistiration = memoCellRegistration()
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistiration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
    
    private func memoCellRegistration() -> UICollectionView.CellRegistration<MemoCollectionViewCell, Memo> {
        UICollectionView.CellRegistration { [weak self] cell, indexPath, itemIdentifier in
            guard let self else { return }
            cell.updateView(itemIdentifier)
            cell.showsSeparator = indexPath.item != self.memoList.count - 1
        }
    }
    
    func updateSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<MemoSection, Memo>()
        snapshot.appendSections([.memo])
        snapshot.appendItems(memoList)
        dataSource?.applySnapshotUsingReloadData(snapshot)
    }
}


