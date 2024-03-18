//
//  ChartView.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/18/24.
//

import UIKit
import Then
import DGCharts

final class ChartView: BaseView {
    
    let totalReadingTime = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .point
        $0.font = .boldSystemFont(ofSize: 50)
    }
    
    private let chart = LineChartView()
    
    override func configureHierarchy() {
        [
            totalReadingTime,
            chart,
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        
        totalReadingTime.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(44)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        chart.snp.makeConstraints { make in
            make.top.equalTo(totalReadingTime.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(300)
        }
    }
    
    override func configureView() {
        
    }
    
}

extension ChartView {
    
    func updateView(_ data: [Stats]) {
        let totalTime = TimeManager.shared.secondsToHoursMinutesSeconds(data.reduce(0) { $0 + $1.readingTime })
        let timeString = TimeManager.shared.makeTimeString(hour: totalTime.0, min: totalTime.1, sec: totalTime.2)
        totalReadingTime.text = timeString
        //configureChart(data)
    }
    
//    private func configureChart(_ data: [Stats]) {
//        guard let sparkline = data.sparkline_in_7d else { return }
//        let datas = sparkline.price
//        
//        var lineChartEntry = [ChartDataEntry]()
//        
//        for i in 0..<datas.count {
//            let value = ChartDataEntry(x: Double(i), y: datas[i])
//            lineChartEntry.append(value)
//        }
//        
//        let set = LineChartDataSet(entries: lineChartEntry)
//        set.colors = [.point]
//        set.highlightEnabled = false
//        set.lineWidth = 2
//        set.circleRadius = 0
//        set.fillColor = .point
//        set.fillAlpha = 0.5
//        set.drawFilledEnabled = true
//        
//        chart.rightAxis.enabled = false
//        chart.leftAxis.enabled = false
//        chart.xAxis.enabled = false
//        chart.doubleTapToZoomEnabled = false
//        chart.data = LineChartData(dataSet: set)
//        chart.legend.enabled = false
//    }
}
