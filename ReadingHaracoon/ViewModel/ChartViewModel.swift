//
//  ChartViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/18/24.
//

import Foundation

final class ChartViewModel {
    
    var repository: StatsRepository?

    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    
    var outputStatsList: Observable<[Stats]> = Observable([])
    
    init() {
        
        do {
            repository = try StatsRepository()
        } catch {
            print("realm 초기화 실패: ", error)
        }
        
        transform()
    }
    
    func transform() {
        
        inputViewWillAppearTrigger.bindOnChanged { [weak self] _ in
            guard let self else { return }
            getStats()
        }
    }

}

extension ChartViewModel {
    
    private func getStats() {
        guard let stats = repository?.fetchStatsTable() else { return }
        outputStatsList.value = Array(stats)
    }
}
