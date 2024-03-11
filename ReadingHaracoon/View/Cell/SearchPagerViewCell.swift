//
//  SearchPagerViewCell.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/10/24.
//

import UIKit
import Kingfisher

final class SearchPagerViewCell: BasePagerViewCell {
    
    let bookImageView = BookImageView(frame: .zero)
    
    let titleLabel = Bold18Label()
    let descriptionLabel = Normal16Label()
    
    override func configureHierarchy() {
        [
            bookImageView,
            titleLabel,
            descriptionLabel,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        bookImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    override func configureView() {
        titleLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 3
        contentView.layer.shadowColor = UIColor.clear.cgColor
    }
    
}

extension SearchPagerViewCell {
    
    func updateView(_ data: RecommendItem) {
        let url = URL(string: data.cover)
        bookImageView.kf.setImage(with: url)
        
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }
}
