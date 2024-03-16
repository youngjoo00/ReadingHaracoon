//
//  SearchDetailCollectionViewCell.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/8/24.
//

import UIKit
import Then

final class DetailSearchCollectionViewCell: BaseCollectionViewCell {
    
    private let bookImageView = BookImageView(frame: .zero)
    private let titleLabel = Bold18Label()
    private let authorLabel = Normal14Label()
    private let publisherLabel = Normal14Label()
    private let descriptionLabel = Normal16Label().then {
        $0.numberOfLines = 0
    }
    
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
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview()
            make.height.equalTo(140)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.top)
            make.leading.equalTo(bookImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        publisherLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(publisherLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
            make.bottom.equalTo(bookImageView.snp.bottom).offset(-10)
            make.trailing.equalTo(contentView).offset(-16)
        }
    }
    
    override func configureView() {

    }
}


extension DetailSearchCollectionViewCell {
    
    func updateView(_ item: SearchItem) {
        let url = URL(string: item.cover)
        bookImageView.kf.setImage(with: url)
        
        titleLabel.text = item.title
        authorLabel.text = item.author
        publisherLabel.text = item.publisher
        descriptionLabel.text = item.description
    }
}
