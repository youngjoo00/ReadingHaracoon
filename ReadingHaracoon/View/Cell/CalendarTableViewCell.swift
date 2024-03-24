//
//  CalendarTableViewCell.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/18/24.
//

import UIKit
import Then

final class CalendarTableViewCell: BaseTableViewCell {
    
    private let bookImageView = BookImageView(frame: .zero)
    private let titleLabel = Bold18Label().then {
        $0.numberOfLines = 2
    }
    private let timeLabel = Normal16Label()
    
    override func configureHierarchy() {
        [
            bookImageView,
            titleLabel,
            timeLabel
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        bookImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(140)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.top)
            make.leading.equalTo(bookImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(bookImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    override func configureView() {
        selectionStyle = .none
    }
}


extension CalendarTableViewCell {
    
    func updateView(_ item: CalendarStatsModel) {
        guard let book = item.book else { return }
        let url = URL(string: book.cover)
        bookImageView.kf.setImage(with: url)

        titleLabel.text = book.title
        
        let time = TimeManager.shared.secondsToHoursMinutesSeconds(item.readingTime)
        let timeString = TimeManager.shared.formatTimeLargestUnitString(hour: time.0, min: time.1, sec: time.2)
        timeLabel.text = "읽은 시간: " + timeString
    }
}
