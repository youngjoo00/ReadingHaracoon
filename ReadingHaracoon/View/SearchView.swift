//
//  SearchView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import UIKit
import Then
import FSPagerView

final class SearchView: BaseView {
    
    let navigationTitle = UILabel().then {
        $0.text = "검색"
    }
    
    let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.placeholder = "책 이름을 검색해보세요"
    }
    
    let tableView = UITableView().then {
        $0.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .background
        $0.separatorStyle = .none
    }

    override func configureHierarchy() {
        [
            searchBar,
            tableView
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
}
