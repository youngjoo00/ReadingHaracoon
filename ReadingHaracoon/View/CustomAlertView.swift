//
//  StorageBookStateView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/12/24.
//

import UIKit

final class CustomAlertView: BaseView {
    
    let titleLabel = Bold18Label()
    let messageLabel = Normal16Label()
    
    let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    let cancelButton = UIButton().then {
        var configuration = UIButton.Configuration.gray()
        configuration.title = "취소"
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .lightGray
        $0.configuration = configuration
    }
    
    let actionButton = UIButton().then {
        var configuration = UIButton.Configuration.gray()
        configuration.title = ""
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .lightGray
        $0.configuration = configuration
    }
    
    override func configureHierarchy() {
        [
            titleLabel,
            messageLabel,
            buttonStackView,
        ].forEach { addSubview($0) }
        
        [
            cancelButton,
            actionButton
        ].forEach { buttonStackView.addArrangedSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
    }
}

extension CustomAlertView {
    
    func updateView(title: String, message: String?, actionTitle: String) {
        titleLabel.text = title
        messageLabel.text = message
        actionButton.configuration?.title = actionTitle
    }
}
