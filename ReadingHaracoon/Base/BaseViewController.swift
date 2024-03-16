//
//  BaseViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import UIKit
import Toast

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background
        self.navigationController?.navigationBar.tintColor = .point
        self.navigationController?.navigationBar.topItem?.title = ""

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }

    func showAlert(title: String, message: String, btnTitle: String, complectionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: btnTitle, style: .default) { _ in
            complectionHandler()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func showToast(message: String) {
        var style = ToastStyle()
        style.backgroundColor = .white
        style.messageColor = .point
        self.view.makeToast(message, duration: 2.5, position: .center, style: style)
    }
    
    func keyboardEndEditing() {
        view.endEditing(true)
    }
    
//    func showCustomAlert(style: CustomModalPresentationStyle = .Alert, title: String, message: String, actionTitle: String) {
//        let alertViewContrller = CustomAlertViewController(title: title, message: message, actionTitle: actionTitle)
//        let transitionDelegate = CustomTransitioningDelegate(style)
//        alertViewContrller.modalPresentationStyle = .custom
//        alertViewContrller.transitioningDelegate = transitionDelegate
//        self.present(alertViewContrller, animated: true)
//    }
}
