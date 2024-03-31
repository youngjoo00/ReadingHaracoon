//
//  TimerView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/17/24.
//

import UIKit

final class TimerView: BaseView {
    
    let titleLabel = Bold18Label().then {
        $0.text = "타이머"
        $0.textAlignment = .center
    }
    
    let verticalButtonStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 30
    }
    
    let timeLabel = Bold18Label().then {
        $0.text = "00:00:00"
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 60)
    }
    
    let horizontalButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    let startStopButton = UIButton().then {
        var configuration = UIButton.Configuration.gray()
        configuration.title = "시작"
        configuration.baseBackgroundColor = .white
        configuration.imagePadding = 10
        $0.configuration = configuration
    }
    
    let resetButton = UIButton().then {
        var configuration = UIButton.Configuration.gray()
        configuration.title = "초기화"
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .lightGray
        configuration.imagePadding = 10
        $0.configuration = configuration
    }
    
    let bottomButtonStackView = UIStackView().then {
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
    
    let saveButton = BottomConfirmButton(title: "저장하기", image: nil).then {
        $0.layer.cornerRadius = 8
    }
    
    override func configureHierarchy() {
        [
            titleLabel,
            verticalButtonStackView,
            bottomButtonStackView,
        ].forEach { addSubview($0) }
        
        [
            timeLabel,
            horizontalButtonStackView,
        ].forEach { verticalButtonStackView.addArrangedSubview($0) }
        [
            resetButton,
            startStopButton,
        ].forEach { horizontalButtonStackView.addArrangedSubview($0) }
        
        [
            cancelButton,
            saveButton,
        ].forEach { bottomButtonStackView.addArrangedSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        verticalButtonStackView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
        }

        horizontalButtonStackView.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        bottomButtonStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if safeAreaInsets.bottom == 0 {
            bottomButtonStackView.snp.makeConstraints { make in
                make.bottom.equalTo(safeAreaInsets).offset(-16)
            }
        } else {
            bottomButtonStackView.snp.makeConstraints { make in
                make.bottom.equalTo(safeAreaLayoutGuide)
            }
        }
    }
}
