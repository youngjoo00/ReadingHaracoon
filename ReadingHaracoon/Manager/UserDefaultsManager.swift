//
//  UserDefalutsManager.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/21/24.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    let userDefaluts = UserDefaults.standard
    let startTimeKey = "startTime"
    let stopTimeKey = "stopTime"
    let timerCheckKey = "timerCheck"
    let runningTimerBookISBNKey = "runningTimerBookISBN"
    
    func getStartTime() -> Date? {
        return userDefaluts.object(forKey: startTimeKey) as? Date
    }
    
    func getStopTime() -> Date? {
        return userDefaluts.object(forKey: stopTimeKey) as? Date
    }
    
    func getTimerCheck() -> Bool {
        return userDefaluts.bool(forKey: timerCheckKey)
    }
    
    func getRunningTimerBookISBN() -> String? {
        return userDefaluts.string(forKey: runningTimerBookISBNKey)
    }
    
    func setStartTime(_ date: Date?) {
        userDefaluts.set(date, forKey: startTimeKey)
    }
    
    func setStopTime(_ date: Date?) {
        userDefaluts.set(date, forKey: stopTimeKey)
    }
    
    func setTimeCheck(_ value: Bool) {
        userDefaluts.set(value, forKey: timerCheckKey)
    }
    
    func setRunningTimerBookISBN(_ isbn: String?) {
        userDefaluts.set(isbn, forKey: runningTimerBookISBNKey)
    }
}
    
