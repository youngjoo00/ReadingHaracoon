//
//  MemoTableViewCell.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/16/24.
//

import UIKit
import Then

final class MemoTableViewCell: BaseTableViewCell {
    
    private let titleLabel = Bold18Label()
    private let contentLabel = Normal16Label().then {
        $0.numberOfLines = 3
    }
    
    private let accessoryImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .point
    }
    
    override func configureHierarchy() {
        [
            titleLabel,
            contentLabel,
            accessoryImageView,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(accessoryImageView.snp.leading).offset(-10)
            make.height.equalTo(18)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(accessoryImageView.snp.leading).offset(-10)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
        accessoryImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(16)
        }
    }
    
    override func configureView() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentLabel.text = nil
    }
}


extension MemoTableViewCell {
    
    func updateView(_ item: Memo) {
        titleLabel.text = item.title
        contentLabel.text = item.content
    }

}
