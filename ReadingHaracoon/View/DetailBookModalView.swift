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
    
    let toReadButton = UIButton().then {
        $0.setTitle("읽을 책", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .point
        $0.layer.cornerRadius = 16
        $0.tag = 0
    }
    
    let readingButton = UIButton().then {
        $0.setTitle("읽고 있는 책", for: .normal)
        $0.setTitleColor(.point, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.tag = 1
    }
    
    let readButton = UIButton().then {
        $0.setTitle("읽은 책", for: .normal)
        $0.setTitleColor(.point, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.tag = 2
    }
    
    let confirmButton = UIButton().then {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "저장하기"
        configuration.baseForegroundColor = .white
        configuration.background.backgroundColor = .point
        $0.configuration = configuration
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
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
            make.bottom.equalToSuperview().offset(-16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        
    }
}


extension DetailBookModalView {
    
    func updateButton(_ selectedButton: UIButton) {

        [toReadButton, readingButton, readButton].forEach { button in
            button.backgroundColor = .white
            button.setTitleColor(.point, for: .normal)
        }

        selectedButton.backgroundColor = .point
        selectedButton.setTitleColor(.white, for: .normal)
    }
    
    func configureConfirmButton(_ isFavorite: Bool) {
        confirmButton.configuration?.title = isFavorite ? "수정하기" : "저장하기"
    }
}
