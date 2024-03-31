//
//  PointBackgroundColorButton.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/27/24.
//

import UIKit
import Then

class PointBackgroundColorButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    convenience init(title: String, image: UIImage?) {
        self.init()
        configureView(title, image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PointBackgroundColorButton {
    
    func configureView(_ title: String, image: UIImage?) {
        var configuration = UIButton.Configuration.gray()
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .point
        configuration.title = title
        configuration.image = image
        configuration.imagePadding = 10
        clipsToBounds = true
        layer.cornerRadius = 16
        self.configuration = configuration
    }
}
