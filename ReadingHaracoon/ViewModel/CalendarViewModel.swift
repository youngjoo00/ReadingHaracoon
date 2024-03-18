//
//  CalendarViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/18/24.
//

import Foundation

struct CalendarStatsModel {
    let book: Book?
    let readingTime: Int
}

final class CalendarViewModel {
    
    var repository: StatsRepository?

    var outputStatsList: Observable<[CalendarStatsModel]> = Observable([])

    init() {
        
        do {
            repository = try StatsRepository()
        } catch {
            print("realm 초기화 실패: ", error)
        }
        
        transform()
    }
    
    func transform() {

    }
    
    func numberOfEventsFor(_ date: Date) -> Int {
        return getDayStats(date).count
    }
    
    func didSelectCalendar(_ date: Date) {
        var temp: [CalendarStatsModel] = []
        for item in getDayStats(date) {
            temp.append(CalendarStatsModel(book: item.superTable.first, readingTime: item.readingTime))
        }
        outputStatsList.value = temp
    }
}

extension CalendarViewModel {
    
    private func getDayStats(_ date: Date) -> [Stats] {
        guard let stats = repository?.fetchStatsTable().filter(DateManager.shared.query(queryType: .today, date: date)) else { return [] }
        return Array(stats)
    }
}
