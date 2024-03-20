//
//  StorageBookCollectionViewCell.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/11/24.
//

import UIKit
import Then

final class StorageBookCollectionViewCell: BaseCollectionViewCell {
    
    let coverImageView = BookImageView(frame: .zero)
    
    let titleLabel = Normal16Label().then {
        $0.numberOfLines = 2
        $0.textColor = .point
        $0.textAlignment = .center
    }
    
    let authorLabel = Normal14Label().then {
        $0.textAlignment = .center
    }
    
    override func configureHierarchy() {
        [
            coverImageView,
            titleLabel,
            authorLabel,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        coverImageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.size.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    override func configureView() {
        
    }
}

extension StorageBookCollectionViewCell {
    
    func updateView(_ data: Book) {
        let url = URL(string: data.cover)
        coverImageView.kf.setImage(with: url)
        
        titleLabel.text = data.title
        authorLabel.text = data.author
    }
}
