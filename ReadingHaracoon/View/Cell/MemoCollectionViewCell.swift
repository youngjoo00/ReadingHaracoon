//
//  MemoCollectionViewCell.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/15/24.
//

import UIKit
import Then

final class MemoCollectionViewCell: BaseCollectionViewCell {
    
    let titleLabel = Bold18Label()
    let contentLabel = Normal16Label().then {
        $0.numberOfLines = 3
    }
    
    let accessoryImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .point
    }
    
    let separatorView = UIView().then {
        $0.backgroundColor = .placeholderText
    }
    var showsSeparator = true {
        didSet {
            updateSeparator()
        }
    }
    
    override func configureHierarchy() {
        [
            titleLabel,
            contentLabel,
            accessoryImageView,
            separatorView,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(18)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.greaterThanOrEqualTo(separatorView.snp.top).offset(-10)
        }
        
        accessoryImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(16)
        }
        
        separatorView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(1)
        }
    }
    
    override func configureView() {
        
    }
}


extension MemoCollectionViewCell {
    
    func updateView(_ item: Memo) {
        titleLabel.text = item.title
        contentLabel.text = item.content
    }
    
    func updateSeparator() {
        separatorView.isHidden = !showsSeparator
    }
}
