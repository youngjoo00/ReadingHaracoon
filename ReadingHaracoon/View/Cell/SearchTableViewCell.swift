//
//  SearchTableViewCell.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/10/24.
//

import FSPagerView
import Then

final class SearchTableViewCell: BaseTableViewCell {
    
    let sectionLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .point
    }
    
    let pagerView = FSPagerView().then {
        $0.register(SearchPagerViewCell.self, forCellWithReuseIdentifier: SearchPagerViewCell.identifier)
        $0.isInfinite = true
        $0.transformer = FSPagerViewTransformer(type: .linear)
    }
    
    override func configureHierarchy() {
        [
            sectionLabel,
            pagerView,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        
        sectionLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(contentView).offset(16)
        }
        
        pagerView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pagerView.itemSize = CGSize(
            width: contentView.frame.width * 0.65,
            height: contentView.frame.height - 40
        )
    }
}

extension SearchTableViewCell {
    
    func updateView(_ text: String) {
        sectionLabel.text = text
    }
}
