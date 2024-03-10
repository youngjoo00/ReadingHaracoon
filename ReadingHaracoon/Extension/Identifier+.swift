//
//  Identifier+.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/10/24.
//

import UIKit

extension UIView {
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }

}
