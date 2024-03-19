//
//  NoNetworkErrorView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/20/24.
//

import UIKit
import SnapKit

final class NoNetworkView: UIView {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "인터넷 연결이 끊겼습니다."
        label.textAlignment = .center
        label.numberOfLines = 0 // 여러 줄 표시 가능
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("다시 시도", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(messageLabel)
        addSubview(retryButton)
    }
    
    private func setupLayout() {
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(20)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
        
        retryButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func retryButtonTapped() {
        print("다시 시도 버튼이 눌렸습니다. 네트워크 연결을 확인해주세요.")
        // 네트워크 연결을 다시 시도하는 로직을 여기에 구현할 수 있습니다.
    }
}
