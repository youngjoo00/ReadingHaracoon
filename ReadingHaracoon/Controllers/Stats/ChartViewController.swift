//
//  ChartViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/18/24.
//

import UIKit
import DGCharts

final class ChartViewController: BaseViewController {
    
    let mainView = ChartView()
    let viewModel = ChartViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.inputViewWillAppearTrigger.value = ()
    }
}

extension ChartViewController {
    
    private func bindViewModel() {
        
        viewModel.outputStatsList.bindOnChanged { [weak self] StatsList in
            guard let self else { return }
            mainView.updateView(StatsList)
        }
    }
    
}
