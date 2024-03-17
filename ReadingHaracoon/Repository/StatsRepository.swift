//
//  StatsRepository.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/17/24.
//

import RealmSwift

final class StatsRepository {
    
    var realm: Realm
    
    init() throws {
        realm = try Realm()
    }
    
    func createStatsItem(_ book: Book, stats: Stats) throws {
        do {
            try realm.write {
                book.statsList.append(stats)
                print(realm.configuration.fileURL!)
            }
        } catch {
            print("통계 생성 실패")
            throw error
        }
    }
    
    func fetchStatsTable() {
        
    }
}
