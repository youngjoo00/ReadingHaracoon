//
//  StorageBookStateView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/12/24.
//

import UIKit

final class CustomModalView: BaseView {
    
    let titleLabel = Bold18Label().then {
        $0.text = "test"
    }
    
    override func configureHierarchy() {
        [
            titleLabel
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
        }
    }
    
    override func configureView() {
        backgroundColor = .black.withAlphaComponent(0.7)
    }
}
