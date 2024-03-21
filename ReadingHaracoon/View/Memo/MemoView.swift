//
//  MemoView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/16/24.
//

import UIKit
import Then

final class MemoView: BaseView {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 60
        $0.backgroundColor = .clear
        $0.register(MemoTableViewCell.self, forCellReuseIdentifier: MemoTableViewCell.identifier)
    }
    
    let noMemoLabel = BasePaddingLabel().then {
        $0.text = "메모가 비어있다쿤!"
        $0.textAlignment = .center
        $0.backgroundColor = .white
        $0.textColor = .point
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    let writeButton = BottomConfirmButton(title: "메모 작성", image: UIImage(systemName: "pencil"))
    
    override func configureHierarchy() {
        [
            tableView,
            noMemoLabel,
            writeButton,
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        noMemoLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        writeButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {

    }
}
