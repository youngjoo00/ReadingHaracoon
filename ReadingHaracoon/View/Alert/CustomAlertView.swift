//
//  StorageBookStateView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/12/24.
//

import UIKit

//protocol CustomAlertViewDelegate: AnyObject {
//    func didCalculateDynamicHeight(_ height: CGFloat)
//}

final class CustomAlertView: BaseView {
    
//    weak var delegate: CustomAlertViewDelegate?
    
    let titleLabel = Bold18Label().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    let messageLabel = Normal16Label().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
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
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(10)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        let totalHegiht = totalHegiht()
//        print(totalHegiht)
//        delegate?.didCalculateDynamicHeight(totalHegiht)
//    }
}

extension CustomAlertView {
    
    func updateView(title: String, message: String?, actionTitle: String) {
        titleLabel.text = title
        messageLabel.text = message
        actionButton.configuration?.title = actionTitle
    }
    
//    func totalHegiht() -> CGFloat {
//        let totalHeight = titleLabel.intrinsicContentSize.height + messageLabel.intrinsicContentSize.height + buttonStackView.intrinsicContentSize.height + 30
//        return totalHeight
//    }
}
