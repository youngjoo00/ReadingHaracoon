//
//  Normal14Label.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/12/24.
//

import UIKit

final class Normal14Label: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Normal14Label {
    
    func configureView() {
        textColor = .point
        font = .systemFont(ofSize: 14)
    }
}
