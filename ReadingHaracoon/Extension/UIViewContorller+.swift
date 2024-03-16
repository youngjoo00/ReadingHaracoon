//
//  UIViewContorller+.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/16/24.
//

import UIKit

extension UIViewController {
    
    func showCustomAlert(style: CustomModalPresentationStyle = .Alert,
                         title: String,
                         message: String?,
                         actionTitle: String,
                         completion: @escaping () -> Void) {
        let alertViewContrller = CustomAlertViewController(title: title, message: message, actionTitle: actionTitle, action: completion)
        let transitionDelegate = CustomTransitioningDelegate(style)
        alertViewContrller.modalPresentationStyle = .custom
        alertViewContrller.transitioningDelegate = transitionDelegate
        self.present(alertViewContrller, animated: true)
    }
}
