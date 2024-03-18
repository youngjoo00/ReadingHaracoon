//
//  SettingTableViewCell.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/19/24.
//

import UIKit
import Then

final class SettingTableViewCell: BaseTableViewCell {
    
    private let titleLabel = Bold18Label()
    
    override func configureHierarchy() {
        [
            titleLabel,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureView() {
        
    }
}


extension SettingTableViewCell {
    
    func updateView(_ item: Memo) {
        titleLabel.text = item.title
    }

}
