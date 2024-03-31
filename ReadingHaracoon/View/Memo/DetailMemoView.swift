//
//  WriteMemoView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/15/24.
//

import UIKit
import Then

final class DetailMemoView: BaseView {
    
    let titleTextField = UITextField().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.placeholder = "제목을 입력하세요!"
    }
    
    let contentTextView = UITextView().then {
        $0.layer.cornerRadius = 16
        $0.font = .systemFont(ofSize: 15)
        $0.textContainer.lineFragmentPadding = 10
    }
    
    let saveButton = BottomConfirmButton(title: "저장하기", image: nil)
    
    let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    let updateButton = BottomConfirmButton(title: "수정하기", image: nil)
    
    let deleteButton = BottomConfirmButton(title: "삭제하기", image: nil).then {
        $0.configuration?.baseForegroundColor = .lightGray
        $0.configuration?.baseBackgroundColor = .white
    }
    
    override func configureHierarchy() {
        [
            titleTextField,
            contentTextView,
            saveButton,
            buttonStackView
        ].forEach { addSubview($0) }
        
        [
            deleteButton,
            updateButton,
        ].forEach { buttonStackView.addArrangedSubview($0) }
    }
    
    override func configureLayout() {
        var hasHomeButton: Bool {
                let window = UIApplication
                    .shared
                    .connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                    .flatMap { $0.windows }
                    .first { $0.isKeyWindow }
                guard let safeAreaBottom =  window?.safeAreaInsets.bottom else {
                    return false
                }
                return safeAreaBottom <= 0
            }
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalToSuperview().multipliedBy(0.5)
        }
        
        saveButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaInsets).inset(16)
            make.height.equalTo(50)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaInsets).inset(16)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        titleTextField.addLeftPadding()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if safeAreaInsets.bottom == 0 {
            saveButton.snp.makeConstraints { make in
                make.bottom.equalTo(safeAreaInsets).offset(-16)
            }
            
            buttonStackView.snp.makeConstraints { make in
                make.bottom.equalTo(safeAreaInsets).offset(-16)
            }
        } else {
            saveButton.snp.makeConstraints { make in
                make.bottom.equalTo(safeAreaLayoutGuide)
            }
            
            buttonStackView.snp.makeConstraints { make in
                make.bottom.equalTo(safeAreaLayoutGuide)
            }
        }
    }
}
