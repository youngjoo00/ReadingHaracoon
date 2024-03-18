//
//  StatsTabView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/18/24.
//

import UIKit
import Tabman
import Then

final class StatsTabView: BaseView {
    
    let tabSpaceView = UIView()
    let bar = TMBar.ButtonBar().then {
        $0.backgroundView.style = .blur(style: .regular)
        $0.layout.contentInset = UIEdgeInsets.zero
        $0.buttons.customize { (button) in
            button.tintColor = .lightGray
            button.selectedTintColor = .point
        }
        $0.indicator.weight = .light
        $0.indicator.tintColor = .point
        $0.indicator.overscrollBehavior = .compress
        $0.layout.alignment = .centerDistributed
        $0.layout.contentMode = .fit
        $0.layout.interButtonSpacing = 0
        $0.layout.transitionStyle = .snap
    }
    
    override func configureHierarchy() {
        addSubview(tabSpaceView)
    }
    
    override func configureLayout() {
        tabSpaceView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    
}
