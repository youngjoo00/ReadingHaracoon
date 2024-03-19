//
//  SettingView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/19/24.
//

import UIKit
import Then

final class SettingView: BaseView {
    
    var tableView = UITableView().then {
        $0.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
    }
    
    override func configureHierarchy() {
        [
            tableView
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
}
