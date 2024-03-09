//
//  BookDetailView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/9/24.
//

import UIKit
import Then

final class BookDetailView: BaseView {
    
    let navigationTitle = UILabel().then {
        $0.text = "Book Detail"
    }
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let coverImageView = UIImageView()
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let publisherLabel = UILabel()
    let descriptionLabel = UILabel().then {
        $0.text = "책 소개"
    }
    let descriptionCotentLabel = UILabel().then {
        $0.numberOfLines = 0
    }
    let isbnLabel = UILabel().then {
        $0.text = "ISBN13"
    }
    let isbnContentLabel = UILabel()
    let categoryLabel = UILabel().then {
        $0.text = "카테고리"
    }
    let categoryContentLabel = UILabel()
    let pageLabel = UILabel().then {
        $0.text = "페이지"
    }
    let pageContentLabel = UILabel()
    let publishDateLabel = UILabel().then {
        $0.text = "출판일"
    }
    let publishDateCotentLabel = UILabel()
    let aladinSourceLabel = UILabel().then {
        $0.text = "자료 제공: 알라딘"
    }
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            coverImageView,
            titleLabel,
            authorLabel,
            publisherLabel,
            descriptionLabel,
            descriptionCotentLabel,
            publishDateLabel,
            publishDateCotentLabel,
            categoryLabel,
            categoryContentLabel,
            pageLabel,
            pageContentLabel,
            isbnLabel,
            isbnContentLabel,
            aladinSourceLabel,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        coverImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(140)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(coverImageView.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(18)
        }
        
        publisherLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(authorLabel.snp.bottom).offset(20)
            make.height.equalTo(18)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(publisherLabel.snp.bottom).offset(20)
        }
        
        descriptionCotentLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
        }
        
        isbnLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLabel.snp.leading)
            make.top.equalTo(descriptionCotentLabel.snp.bottom).offset(20)
        }
        
        isbnContentLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(isbnLabel.snp.bottom).offset(10)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLabel.snp.leading)
            make.top.equalTo(isbnContentLabel.snp.bottom).offset(20)
        }
        
        categoryContentLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
        }
        
        pageLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLabel.snp.leading)
            make.top.equalTo(categoryContentLabel.snp.bottom).offset(20)
        }
        
        pageContentLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(pageLabel.snp.bottom).offset(10)
        }
        
        publishDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLabel.snp.leading)
            make.top.equalTo(pageContentLabel.snp.bottom).offset(20)
        }
        
        publishDateCotentLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(publishDateLabel.snp.bottom).offset(10)
        }
        
        aladinSourceLabel.snp.makeConstraints { make in
            make.top.equalTo(publishDateCotentLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    override func configureView() {
        
    }
}

extension BookDetailView {
    
    func updateView(_ data: InquiryItem) {
        let url = URL(string: data.cover)
        coverImageView.kf.setImage(with: url)
        
        titleLabel.text = data.title
        authorLabel.text = data.author
        publisherLabel.text = data.publisher
        descriptionCotentLabel.text = data.description
        publishDateCotentLabel.text = data.pubDate
        categoryContentLabel.text = data.categoryName
        pageContentLabel.text = "\(data.subInfo.itemPage)"
        isbnContentLabel.text = data.isbn13
    }
}
