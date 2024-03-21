//
//  NoNetworkErrorView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/20/24.
//

import UIKit
import Then

final class NoNetworkView: UIView {
    
    private let messageLabel = Bold18Label().then {
        $0.text = "인터넷 연결을 확인해보라쿤!"
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(messageLabel)
    }
    
    private func setupLayout() {
        messageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.greaterThanOrEqualToSuperview().inset(16)
        }
    }

}
