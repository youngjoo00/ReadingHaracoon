//
//  AladinWebViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/10/24.
//

import UIKit

final class AladinWebViewController: BaseViewController {
    
    let mainView = AladinWebView()
    let viewModel = AladinWebViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        navigationItem.titleView = mainView.navigationTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.inputViewWillAppearTrigger.value = ()
    }
}


// MARK: - Custom Func
extension AladinWebViewController {
    
    func bindViewModel() {
        viewModel.outputURLRequest.bind { [weak self] urlRequest in
            guard let self, let urlRequest else { return }
            self.mainView.webView.load(urlRequest)
        }
    }
    
}
