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
    
    private let totalReadingLabel = UILabel().then {
        $0.text = "총 독서 시간"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .center
        $0.textColor = .point
    }
    
    private let totalReadingTimeLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .point
        $0.font = .boldSystemFont(ofSize: 35)
    }
    
    private let chartLabel = Bold18Label().then {
        $0.text = "월별 독서 시간 (단위: 시간)"
    }
    
    private let barChartView = BarChartView()
    private let markerView = ChartMarker()
    
    override func configureHierarchy() {
        [
            totalReadingLabel,
            totalReadingTimeLabel,
            chartLabel,
            barChartView,
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        
        totalReadingLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(64)
            make.centerX.equalToSuperview()
        }
        
        totalReadingTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(totalReadingLabel.snp.bottom).offset(10)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        chartLabel.snp.makeConstraints { make in
            make.top.equalTo(totalReadingTimeLabel.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        barChartView.snp.makeConstraints { make in
            make.top.equalTo(chartLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(250)
        }
    }
    
    override func configureView() {
        barChartView.marker = markerView
        barChartView.backgroundColor = .white
        barChartView.clipsToBounds = true
        barChartView.layer.cornerRadius = 16
        barChartView.rightAxis.enabled = false
        barChartView.xAxis.labelPosition = .bottom
        barChartView.legend.enabled = false
        barChartView.noDataText = "데이터가 없습니다."
        barChartView.noDataFont = .systemFont(ofSize: 20)
        barChartView.noDataTextColor = .point
        barChartView.doubleTapToZoomEnabled = false
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        barChartView.leftAxis.axisMinimum = 0
        
        // X축과 Y축의 눈금선 설정
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false

        barChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: NumberFormatter())
        barChartView.leftAxis.granularity = 1
    }
    
}

extension ChartView {
    
    func updateView(_ data: [Stats]) {
        totalReadingTimeLabel.text = formattedReadingTimeToString(data)
        configureChart(data)
    }
    
    private func formattedReadingTimeToString(_ data: [Stats]) -> String {
        let totalReadingTime = TimeManager.shared.secondsToHoursMinutesSeconds(data.reduce(0) { $0 + $1.readingTime })
        let timeString = TimeManager.shared.formatTimeLargestUnitString(hour: totalReadingTime.0,
                                                                        min: totalReadingTime.1,
                                                                        sec: totalReadingTime.2)
        return timeString
    }
    
    private func configureChart(_ data: [Stats]) {
        // 월별 독서시간 합계
        var totalReadingTimeMonth: [Int: Int] = [:]

        for item in data {
            let calendar = Calendar.current
            guard let month = calendar.dateComponents([.month], from: item.readingDate).month else { return }
            let readingTime = item.readingTime

            if let currentReadingTime = totalReadingTimeMonth[month] {
                totalReadingTimeMonth[month] = currentReadingTime + readingTime
            } else {
                totalReadingTimeMonth[month] = readingTime
            }
        }

        var barChartEntry = [BarChartDataEntry]()
        for month in 1...12 {
            let readingTime = totalReadingTimeMonth[month] ?? 0
            let hours = readingTime / 3600
            let minutes = (readingTime % 3600) / 60

            // 시간 + 분을 막대그래프의 값으로 설정
            let value = BarChartDataEntry(x: Double(month - 1), y: Double(hours) + Double(minutes) / 60.0)
            barChartEntry.append(value)
        }

        let set = BarChartDataSet(entries: barChartEntry)
        set.colors = [.point]

        // 정수형으로 값 표시를 위한 포맷터 설정
        let formatter = DefaultValueFormatter(decimals: 0)
        set.valueFormatter = formatter

        let months: [String] = (1...12).map { "\($0)월" }
        
        barChartView.data = BarChartData(dataSet: set)
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        barChartView.xAxis.setLabelCount(months.count, force: false)
    }

}
