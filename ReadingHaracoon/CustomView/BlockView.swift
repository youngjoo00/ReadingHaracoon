//
//  BlockView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/12/24.
//

import UIKit
import Then

final class BlockView: BaseView {

    let customModalView = CustomModalView()
    
    override func configureHierarchy() {
        [
            customModalView
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        customModalView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = .white.withAlphaComponent(0.7)
        isHidden = true
    }
    
}

extension BlockView {
    
}
