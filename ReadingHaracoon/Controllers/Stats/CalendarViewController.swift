//
//  CalendarViewController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/18/24.
//

import UIKit
import FSCalendar

final class CalendarViewController: BaseViewController {
    
    let mainView = CalendarView()
    let viewModel = CalendarViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainView.calendar.reloadData()
        mainView.tableView.reloadData()
    }
}


extension CalendarViewController {
    
    private func configureView() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
    }
 
    private func bindViewModel() {
        viewModel.outputStatsList.bindOnChanged { [weak self] stats in
            guard let self else { return }
            mainView.tableView.reloadData()
        }
    }
}


extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputStatsList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarTableViewCell.identifier, for: indexPath) as? CalendarTableViewCell else { return UITableViewCell() }
        
        let row = viewModel.outputStatsList.value[indexPath.row]
        cell.updateView(row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("나중에 합시다..")
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return viewModel.numberOfEventsFor(date)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.didSelectCalendar(date)
    }
}
