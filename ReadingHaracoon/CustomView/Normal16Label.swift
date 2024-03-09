//
//  Normal18Label.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/10/24.
//

import UIKit

final class Normal16Label: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Normal16Label {
    
    func configureView() {
        textColor = .black
        font = .systemFont(ofSize: 16)
    }
}
