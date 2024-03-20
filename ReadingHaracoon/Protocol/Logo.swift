//
//  Logo.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/19/24.
//

import UIKit

protocol Logo {
    func configureLogo()
}

extension UIViewController: Logo {
    func configureLogo() {
        let logoImage = UIImage(resource: .logo)
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.contentMode = .scaleAspectFill
        
        let logoTypeImage = UIImage(resource: .logotype)
        let logoTypeImageView = UIImageView(image: logoTypeImage)
        logoTypeImageView.contentMode = .scaleAspectFill
        
        logoImageView.frame = CGRect(x: 0, y: 0, width: 33, height: 40)
        logoTypeImageView.frame = CGRect(x: 20, y: 0, width: 150, height: 40)
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        container.addSubview(logoImageView)
        container.addSubview(logoTypeImageView)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: container)
    }
}
