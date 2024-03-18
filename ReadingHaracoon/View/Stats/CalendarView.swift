//
//  CalendarView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/18/24.
//

import UIKit
import Then
import FSCalendar

final class CalendarView: BaseView {
    
    let calendar = FSCalendar().then {
        $0.locale = Locale(identifier: "ko-KR")
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.appearance.weekdayTextColor = .point // 요일 색상
        $0.appearance.headerTitleFont = .boldSystemFont(ofSize: 20) //타이틀 폰트 크기
        $0.appearance.headerMinimumDissolvedAlpha = 0.0 //헤더 좌,우측 흐릿한 글씨 삭제
        $0.appearance.headerDateFormat = "YYYY년 M월" //날짜(헤더) 표시 형식
        $0.appearance.headerTitleColor = .point //2021년 1월(헤더) 색
        $0.appearance.titleWeekendColor = .systemGray //주말 날짜 색
        $0.appearance.titleDefaultColor = .point //기본 날짜 색
    }
    
    let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.register(CalendarTableViewCell.self, forCellReuseIdentifier: CalendarTableViewCell.identifier)
    }
    
    override func configureHierarchy() {
        [
            calendar,
            tableView,
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(44)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(10)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
    
}

