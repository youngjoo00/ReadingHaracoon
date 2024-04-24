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
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleMessage), name: .receivedMessage, object: nil)
    }
    
    @objc func handleMessage(_ notification: Notification) {
        if let message = notification.userInfo?["message"] as? String {
            showToast(message: message)
        }
    }
    
    func showToast(message: String) {
        var style = ToastStyle()
        style.backgroundColor = .point
        style.messageColor = .white
        self.view.makeToast(message, duration: 2.5, position: .center, style: style)
    }
    
    func keyboardEndEditing() {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
