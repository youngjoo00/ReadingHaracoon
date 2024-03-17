//
//  TimerViewModel.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/17/24.
//

import Foundation

final class TimerViewModel {
    
    var repository: StatsRepository?
    var bookData: Book?
    var timerCheck = false
    var startTime: Date?
    var stopTime: Date?
    var scheculedTimer: Timer!
    var currentTime = 0
    
    let userDefaluts = UserDefaults.standard
    let startTimeKey = "startTime"
    let stopTimeKey = "stopTime"
    let timerCheckKey = "timerCheck"

    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputDidStartStopButtonTappedTrigger: Observable<Void?> = Observable(nil)
    var inputDidResetButtonTappedTrigger: Observable<Void?> = Observable(nil)
    var inputDidSaveButtonTappedTrigger: Observable<Void?> = Observable(nil)
    
    var outputStartStopButtonState = Observable(false)
    var outputTimeLabelText = Observable("")
    var outputDataBaseReslutMessage = Observable<DatabaseResultMessage>(.success(""))
    
    init() {
        
        do {
            repository = try StatsRepository()
        } catch {
            print("realm 초기화 실패: ", error)
        }
        
        transform()
    }
    
    func transform() {
        inputViewDidLoadTrigger.bindOnChanged { [weak self] _ in
            guard let self else { return }
            
            startTime = userDefaluts.object(forKey: startTimeKey) as? Date
            stopTime = userDefaluts.object(forKey: stopTimeKey) as? Date
            timerCheck = userDefaluts.bool(forKey: timerCheckKey)
            
            if timerCheck {
                startTimer()
            } else {
                stopTimer()
                if let start = startTime, let stop = stopTime {
                    let time = calcRestartTime(start: start, stop: stop)
                    let diff = Date().timeIntervalSince(time)
                    setTimeLabel(Int(diff))
                }
            }

        }
        
        inputDidStartStopButtonTappedTrigger.bindOnChanged { [weak self] _ in
            guard let self else { return }
            
            if timerCheck {
                setStopTime(date: Date())
                stopTimer()
            } else {
                if let stop = stopTime {
                    let restartTime = calcRestartTime(start: startTime ?? Date(), stop: stop)
                    setStopTime(date: nil)
                    setStartTime(date: restartTime)
                } else {
                    setStartTime(date: Date())
                }
                startTimer()
            }
        }
        
        inputDidResetButtonTappedTrigger.bindOnChanged { [weak self] _ in
            guard let self else { return }
            
            setStopTime(date: nil)
            setStartTime(date: nil)
            let timeString = makeTimeString(hour: 0, min: 0, sec: 0)
            outputTimeLabelText.value = timeString
            stopTimer()
        }
        
        inputDidSaveButtonTappedTrigger.bindOnChanged { [weak self] _ in
            guard let self, currentTime != 0 else {
                self?.outputDataBaseReslutMessage.value = .fail("저장할 시간이 없다쿤!")
                return
            }
            
            createStats()
        }
    }
    
}

extension TimerViewModel {

    private func createStats() {
        guard let book = bookData else { return }
        do {
            let stats = Stats(readingTime: currentTime, readingDate: Date())
            try repository?.createStatsItem(book, stats: stats)
            outputDataBaseReslutMessage.value = .success("타이머 저장에 성공했다쿤!")
            inputDidResetButtonTappedTrigger.value = ()
        } catch {
            outputDataBaseReslutMessage.value = .fail("타이머 저장에 실패했다쿤..")
        }
        
    }
    
    private func startTimer() {
        scheculedTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refershValue), userInfo: nil, repeats: true)
        setTimeCounting(true)
        outputStartStopButtonState.value = true
    }
    
    private func stopTimer() {
        if scheculedTimer != nil {
            scheculedTimer.invalidate()
        }
        setTimeCounting(false)
        outputStartStopButtonState.value = false
    }
    
    @objc private func refershValue() {
        if let start = startTime {
            // 현재 시간 - 시작시간 = 타이머 시간
            let diff = Date().timeIntervalSince(start)
            setTimeLabel(Int(diff))
        } else {
            stopTimer()
            setTimeLabel(0)
        }
    }
    
    private func setTimeLabel(_ value: Int) {
        currentTime = value
        let time = secondsToHoursMinutesSeconds(value)
        let timeString = makeTimeString(hour: time.0, min: time.1, sec: time.2)
        outputTimeLabelText.value = timeString
    }
    
    private func secondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int) {
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        
        return (hour, min, sec)
    }
    
    private func makeTimeString(hour: Int, min: Int, sec: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hour)
        timeString += ":"
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        return timeString
    }
    
    private func calcRestartTime(start: Date, stop: Date) -> Date {
        // 시작시간 재설정
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    
    private func setStartTime(date: Date?) {
        startTime = date
        userDefaluts.set(startTime, forKey: startTimeKey)
    }
    
    private func setStopTime(date: Date?) {
        stopTime = date
        userDefaluts.set(stopTime, forKey: stopTimeKey)
    }
    
    private func setTimeCounting(_ value: Bool) {
        timerCheck = value
        userDefaluts.set(timerCheck, forKey: timerCheckKey)
    }
}
