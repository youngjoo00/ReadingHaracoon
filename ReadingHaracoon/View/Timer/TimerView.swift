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
    
    let timeLabel = Bold18Label().then {
        $0.text = "00:00:00"
        $0.textAlignment = .center
    }
    
    let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    let startStopButton = UIButton().then {
        var configuration = UIButton.Configuration.gray()
        configuration.title = "START"
        configuration.image = UIImage(systemName: "play")
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .lightGray
        configuration.imagePadding = 10
        $0.configuration = configuration
    }
    
    let resetButton = UIButton().then {
        var configuration = UIButton.Configuration.gray()
        configuration.title = "RESET"
        configuration.image = UIImage(systemName: "reset")
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .lightGray
        configuration.imagePadding = 10
        $0.configuration = configuration
    }
    
    let saveButton = UIButton().then {
        var configuration = UIButton.Configuration.gray()
        configuration.title = "저장하기"
        configuration.image = UIImage(systemName: "pencil")
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .lightGray
        configuration.imagePadding = 10
        $0.configuration = configuration
    }
    
    override func configureHierarchy() {
        [
            titleLabel,
            timeLabel,
            buttonStackView,
            saveButton,
        ].forEach { addSubview($0) }
        
        [
            startStopButton,
            resetButton
        ].forEach { buttonStackView.addArrangedSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        
    }
}
