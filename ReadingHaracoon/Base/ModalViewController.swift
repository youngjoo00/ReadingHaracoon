//
//  ModalViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/31/24.
//

import UIKit
import Toast

class ModalViewController: UIViewController {

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
    
    func showToast(message: String) {
        var style = ToastStyle()
        style.backgroundColor = .point
        style.messageColor = .white
        self.view.makeToast(message, duration: 2.5, position: .center, style: style)
    }
    
    func keyboardEndEditing() {
        view.endEditing(true)
    }
    
}
