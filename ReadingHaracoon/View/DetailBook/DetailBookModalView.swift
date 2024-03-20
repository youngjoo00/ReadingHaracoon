//
//  StorageModalView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/13/24.
//

import UIKit

final class DetailBookModalView: BaseView {
    
    let titleLabel = Bold18Label().then {
        $0.text = "책 상태를 설정하라쿤!"
    }
    
    let closeButton = UIButton().then {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "xmark.circle.fill")
        configuration.baseForegroundColor = .black
        configuration.background.backgroundColor = .clear
        $0.configuration = configuration
    }
    
    let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    let toReadButton = BottomConfirmButton(title: "읽을 책", image: UIImage(systemName: "bookmark.fill")).then {
        $0.configuration?.imagePlacement = .top
        $0.tag = 0
    }
    
    let readingButton = BottomConfirmButton(title: "읽고 있는 책", image: UIImage(systemName: "book.fill")).then {
        $0.configuration?.imagePlacement = .top
        $0.tag = 1
    }
    
    let readButton = BottomConfirmButton(title: "읽은 책", image: UIImage(systemName: "book.closed")).then {
        $0.configuration?.imagePlacement = .top
        $0.tag = 2
    }
    
    
    let confirmButton = BottomConfirmButton(title: "저장하기", image: nil)
    
    override func configureHierarchy() {
        [
            titleLabel,
            closeButton,
            buttonStackView,
            confirmButton,
        ].forEach { addSubview($0) }
        
        [
            toReadButton, readingButton, readButton
        ].forEach { buttonStackView.addArrangedSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(-5)
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(30)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        
    }
}


extension DetailBookModalView {
    
    func updateButton(_ selectedButtonTag: Int) {
        [toReadButton, readingButton, readButton].forEach { button in
            if selectedButtonTag == button.tag {
                button.configuration?.baseForegroundColor = .white
                button.configuration?.baseBackgroundColor = .point
            } else {
                button.configuration?.baseForegroundColor = .lightGray
                button.configuration?.baseBackgroundColor = .white
            }
        }
    }
    
    func configureConfirmButton(_ isFavorite: Bool) {
        confirmButton.configuration?.title = isFavorite ? "수정하기" : "저장하기"
    }
}
