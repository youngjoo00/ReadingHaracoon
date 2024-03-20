//
//  MemoTableViewCell.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/16/24.
//

import UIKit
import Then

final class MemoTableViewCell: BaseTableViewCell {
    
    private let backgroundCellView = UIView()
    private let titleLabel = Bold18Label()
    private let contentLabel = Normal16Label().then {
        $0.numberOfLines = 3
    }
    
    private let dateLabel = Normal14Label()
    
    override func configureHierarchy() {
        [
            backgroundCellView,
            titleLabel,
            contentLabel,
            dateLabel
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(18)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
        }
    }
    
    override func configureView() {
        backgroundColor = .white
        layer.cornerRadius = 16
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
        dateLabel.text = DateManager.shared.formatDateString(date: item.regDate)
    }

}
