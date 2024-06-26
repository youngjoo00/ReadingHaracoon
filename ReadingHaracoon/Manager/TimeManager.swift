//
//  TimerManager.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/18/24.
//

import Foundation

final class TimeManager {
    
    static let shared = TimeManager()
    
    private init() { }
    
    func secondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int) {
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        
        return (hour, min, sec)
    }
    
    func formatTimeLargestUnitString(hour: Int, min: Int, sec: Int) -> String {
        var timeString = ""
        if hour > 0 {
            timeString += "\(hour)"
            timeString += "시간 "
        }
        if min > 0 {
            timeString += "\(min)"
            timeString += "분 "
        }
        if timeString.isEmpty {
            timeString += "\(sec)"
            timeString += "초"
        }
        return timeString
    }
    
    func formatTimeString(hour: Int, min: Int, sec: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hour)
        timeString += ":"
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        return timeString
    }
}
    
