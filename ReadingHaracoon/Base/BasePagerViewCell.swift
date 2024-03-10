//
//  BasePagerViewCell.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/10/24.
//

import FSPagerView

class BasePagerViewCell: FSPagerViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() { }
}
