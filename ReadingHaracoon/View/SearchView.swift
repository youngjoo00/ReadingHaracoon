//
//  SearchView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import UIKit
import Then

final class SearchView: BaseView {
    
    let navigationTitle = UILabel().then {
        $0.text = "검색"
    }
    
    let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.placeholder = "책 이름을 검색해보세요"
    }
    
    override func configureHierarchy() {
        [
            searchBar
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureView() {
        
    }
}
