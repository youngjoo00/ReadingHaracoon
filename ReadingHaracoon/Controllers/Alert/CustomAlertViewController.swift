//
//  CustomAlertViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/16/24.
//

import UIKit

final class CustomAlertViewController: BaseViewController {
    
    private let alertTitle: String
    private let alertMessage: String?
    private let actionTitle: String
    
    var action: (() -> Void)?
    let mainView = CustomAlertView()
    
    init(title: String, message: String?, actionTitle: String, action: @escaping () -> Void) {
        self.alertTitle = title
        self.alertMessage = message
        self.actionTitle = actionTitle
        self.action = action
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.updateView(title: alertTitle, message: alertMessage, actionTitle: actionTitle)
        mainView.actionButton.addTarget(self, action: #selector(didActionButtonTapped), for: .touchUpInside)
        mainView.cancelButton.addTarget(self, action: #selector(didCancelButtonTapped), for: .touchUpInside)
    }
}

extension CustomAlertViewController {
    
    @objc func didActionButtonTapped() {
        action?()
        dismiss(animated: true)
    }

    @objc func didCancelButtonTapped() {
        dismiss(animated: true)
    }
}
