//
//  Bold20Label.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/10/24.
//

import UIKit

final class Bold18Label: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Bold18Label {
    
    func configureView() {
        textColor = .point
        font = .boldSystemFont(ofSize: 18)
    }
}
