//
//  CustomTransitioningDelegate.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/13/24.
//

import UIKit

final class CustomTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var customModalPresentationStyle: CustomModalPresentationStyle = .bottom
    
    init(_ customModalPresentationStyle: CustomModalPresentationStyle) {
        self.customModalPresentationStyle = customModalPresentationStyle
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = CustomPresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.customModalPresentationStyle = customModalPresentationStyle
        return presentationController
    }
    
}
