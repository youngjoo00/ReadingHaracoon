//
//  FavoriteViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import UIKit

final class StorageBookViewController: BaseViewController {
    
    let mainView = StorageBookView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = mainView.navigationTitle
    }
}
