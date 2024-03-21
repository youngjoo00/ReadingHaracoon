//
//  BookDetailView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/9/24.
//

import UIKit
import Then

final class DetailBookView: BaseView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let bookImageView = BookImageView(frame: .zero)
    let titleLabel = Bold18Label()
    let authorLabel = Normal16Label()
    let publisherLabel = Normal16Label()
    let descriptionLabel = Bold18Label().then {
        $0.text = "책 소개"
    }
    let descriptionCotentLabel = Normal16Label().then {
        $0.numberOfLines = 0
    }
    let linkLabel = Bold18Label().then {
        $0.text = "링크"
    }
    let linkButton = UIButton().then {
        var configuration = UIButton.Configuration.gray()
        configuration.title = "링크로 이동하기"
        configuration.baseForegroundColor = .systemBlue
        configuration.baseBackgroundColor = .white
        $0.configuration = configuration
    }
    let isbnLabel = Bold18Label().then {
        $0.text = "ISBN13"
    }
    let isbnContentLabel = Normal16Label()
    let categoryLabel = Bold18Label().then {
        $0.text = "카테고리"
    }
    let categoryContentLabel = Normal16Label()
    let pageLabel = Bold18Label().then {
        $0.text = "페이지"
    }
    let pageContentLabel = Normal16Label()
    let aladinSourceLabel = UILabel().then {
        $0.text = "자료 제공: 알라딘"
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .point
    }
    
    let bottomView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let bottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    let bookStatusButton = BottomConfirmButton(title: "책 상태", image: UIImage(systemName: "book.pages")).then {
        $0.layer.cornerRadius = 8
    }
    
    let memoButton = BottomConfirmButton(title: "메모", image: UIImage(systemName: "pencil")).then {
        $0.layer.cornerRadius = 8
    }
    
    let timerButton = BottomConfirmButton(title: "타이머", image: UIImage(systemName: "timer")).then {
        $0.layer.cornerRadius = 8
    }
    
    let storageButton = BottomConfirmButton(title: "책 저장하기", image: nil)
    
    let overSafeAreabottomView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let separateView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    let scrollBottomSpaceView = UIView()
    
    override func configureHierarchy() {
        [
            scrollView,
            overSafeAreabottomView,
            bottomView,
        ].forEach { addSubview($0) }
        
        scrollView.addSubview(contentView)
        [
            bookImageView,
            titleLabel,
            authorLabel,
            publisherLabel,
            separateView,
            descriptionLabel,
            descriptionCotentLabel,
            linkLabel,
            linkButton,
            categoryLabel,
            categoryContentLabel,
            pageLabel,
            pageContentLabel,
            isbnLabel,
            isbnContentLabel,
            aladinSourceLabel,
            scrollBottomSpaceView,
        ].forEach { contentView.addSubview($0) }
        
        [
            storageButton,
            bottomStackView
        ].forEach { bottomView.addSubview($0) }
        
        [
            bookStatusButton,
            memoButton,
            timerButton
        ].forEach { bottomStackView.addArrangedSubview($0) }
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        bookImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(150)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(bookImageView.snp.bottom).offset(20)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        publisherLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(authorLabel.snp.bottom).offset(10)
        }
        
        separateView.snp.makeConstraints { make in
            make.top.equalTo(publisherLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(separateView.snp.bottom).offset(20)
        }
        
        descriptionCotentLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
        }
        
        linkLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLabel.snp.leading)
            make.top.equalTo(descriptionCotentLabel.snp.bottom).offset(20)
        }
        
        linkButton.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLabel.snp.leading)
            make.top.equalTo(linkLabel.snp.bottom).offset(10)
        }
        
        isbnLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLabel.snp.leading)
            make.top.equalTo(linkButton.snp.bottom).offset(20)
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
        
        aladinSourceLabel.snp.makeConstraints { make in
            make.top.equalTo(pageContentLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        scrollBottomSpaceView.snp.makeConstraints { make in
            make.top.equalTo(aladinSourceLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(60)
        }

        storageButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        overSafeAreabottomView.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.bottom)
            make.bottom.horizontalEdges.equalToSuperview()
        }
        
    }
    
    override func configureView() {
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        authorLabel.numberOfLines = 0
        authorLabel.textAlignment = .center
        publisherLabel.numberOfLines = 0
        publisherLabel.textAlignment = .center
    }
}



extension DetailBookView {
    
    func updateBottomView(_ isFavorite: Bool) {
        if isFavorite {
            storageButton.isHidden = true
            bottomStackView.isHidden = false
        } else {
            storageButton.isHidden = false
            bottomStackView.isHidden = true
        }
    }
    
    func updateView(_ data: UpdateView) {
        switch data {
        case .InquiryItem(let data):
            updateView(data)
        case .Book(let data):
            updateView(data)
        }
    }
    
    private func updateView(_ data: InquiryItem) {
        let url = URL(string: data.cover)
        bookImageView.kf.setImage(with: url)
        
        titleLabel.text = data.title
        authorLabel.text = data.author
        publisherLabel.text = data.publisher
        descriptionCotentLabel.text = data.description
        categoryContentLabel.text = data.categoryName
        pageContentLabel.text = "\(data.subInfo.itemPage)"
        isbnContentLabel.text = data.isbn13
    }
    
    private func updateView(_ data: Book) {
        let url = URL(string: data.cover)
        bookImageView.kf.setImage(with: url)
        
        titleLabel.text = data.title
        authorLabel.text = data.author
        publisherLabel.text = data.publisher
        descriptionCotentLabel.text = data.descript
        categoryContentLabel.text = data.categoryName
        pageContentLabel.text = "\(data.page)"
        isbnContentLabel.text = data.isbn
    }
    

}
