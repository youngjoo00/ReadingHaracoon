//
//  StorageFilterModalView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/14/24.
//

import UIKit

// 최신순, 오래된 순 -> 저장일, 쪽수
final class StorageFilterModalView: BaseView {
    
    private var buttons: [UIButton] = []
    
    let titleLabel = Bold18Label().then {
        $0.text = "원하는 형태로 필터링하라쿤!"
    }
    
    let closeButton = UIButton().then {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "xmark.circle.fill")
        configuration.baseForegroundColor = .black
        configuration.background.backgroundColor = .clear
        $0.configuration = configuration
    }
    
    let storageButton = UIButton().then {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "적용하기"
        configuration.baseForegroundColor = .white
        configuration.background.backgroundColor = .point
        $0.configuration = configuration
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    let filterSegmentControl = UISegmentedControl().then {
        $0.insertSegment(withTitle: "최신순", at: 0, animated: true)
        $0.insertSegment(withTitle: "오래된 순", at: 1, animated: true)
        $0.selectedSegmentIndex = 0
    }
    
    let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    let storageDateButton = UIButton().then {
        $0.setTitle("등록일", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .point
        $0.layer.cornerRadius = 16
    }
    
    let pageButton = UIButton().then {
        $0.setTitle("쪽수", for: .normal)
        $0.setTitleColor(.point, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
    }
    
    override func configureHierarchy() {
        [
            titleLabel,
            closeButton,
            filterSegmentControl,
            buttonStackView,
            storageButton,
        ].forEach { addSubview($0) }
        
        buttons = [storageDateButton, pageButton]
        buttons.forEach { buttonStackView.addArrangedSubview($0) }
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
        
        filterSegmentControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        filterSegmentControl.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        buttonStackView.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(filterSegmentControl.snp.bottom).offset(20)
            make.bottom.lessThanOrEqualTo(storageButton.snp.top).offset(-20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        buttonStackView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        storageButton.snp.makeConstraints { make in
            make.height.equalTo(buttonStackView)
        }
        
        storageButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        storageButton.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    override func configureView() {
        
        for (index, button) in buttons.enumerated() {
            button.tag = FilterContent.allCases[index].rawValue
        }
    }
}

extension StorageFilterModalView {
    
    func updateView(_ filterContent: FilterContent) {
        updateSegmentControlTitle(filterContent)
        updateButton(filterContent.rawValue)
    }
    
    private func updateSegmentControlTitle(_ tag: FilterContent) {
    
        switch tag {
        case .regDate:
            filterSegmentControl.setTitle("최신순", forSegmentAt: 0)
            filterSegmentControl.setTitle("오래된순", forSegmentAt: 1)
        case .page:
            filterSegmentControl.setTitle("높은순", forSegmentAt: 0)
            filterSegmentControl.setTitle("낮은순", forSegmentAt: 1)
        }
    }
    
    private func updateButton(_ tag: Int) {
        
        buttons.forEach { button in
            button.backgroundColor = .white
            button.setTitleColor(.point, for: .normal)
        }
        
        if let selectedButton = buttons.first(where: { $0.tag == tag }) {
            selectedButton.backgroundColor = .point
            selectedButton.setTitleColor(.white, for: .normal)
        }
    }
}
