//
//  SearchDetailCollectionViewCell.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/8/24.
//

import UIKit
import Then

class SearchDetailCollectionViewCell: BaseCollectionViewCell {
    
    let bookImageView = UIImageView()
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let publisherLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override func configureHierarchy() {
        [
            bookImageView,
            titleLabel,
            authorLabel,
            publisherLabel,
            descriptionLabel
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        bookImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.height.equalTo(140)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.top).offset(10)
            make.leading.equalTo(bookImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(18)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
            make.height.equalTo(15)
        }
        
        publisherLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
            make.height.equalTo(15)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(publisherLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
            make.bottom.equalTo(bookImageView.snp.bottom).offset(-10)
            make.trailing.equalTo(contentView).offset(-16)
        }
    }
    
    override func configureView() {

    }
    

    
}

