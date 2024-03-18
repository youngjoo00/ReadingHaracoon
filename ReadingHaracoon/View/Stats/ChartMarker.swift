//
//  ChartMarker.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/19/24.
//

import UIKit
import DGCharts

class ChartMarker: MarkerView {
    private var timeText = String()

    private let drawAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 15),
        .foregroundColor: UIColor.point,
        .backgroundColor: UIColor.white
    ]

    // 터치 시 보여줄 콘텐츠 값
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        let hours = Int(entry.y)
        let minutes = Int((entry.y - Double(hours)) * 60)
        timeText = TimeManager.shared.formatTimeLargestUnitString(hour: hours, min: minutes, sec: 0)
    }

    // 커스텀 뷰 드로잉
    override func draw(context: CGContext, point: CGPoint) {
        super.draw(context: context, point: point)

        // 텍스트의 크기를 계산하고, 여백을 추가하여 뷰의 bounds를 설정
        let sizeForDrawing = timeText.size(withAttributes: drawAttributes)
        bounds.size = CGSize(width: sizeForDrawing.width + 16, height: sizeForDrawing.height + 8) // 여백 추가
        layer.cornerRadius = 8

        // 텍스트 박스 위치
        offset = CGPoint(x: -bounds.size.width / 2, y: -bounds.size.height - 4)

        let offset = offsetForDrawing(atPoint: point)
        let originPoint = CGPoint(x: point.x + offset.x, y: point.y + offset.y)
        let rectForText = CGRect(origin: originPoint, size: bounds.size)
        
        // 둥근 배경 그리기
        context.saveGState()
        context.setFillColor(UIColor.white.cgColor)

        let roundedRectPath = UIBezierPath(roundedRect: rectForText, cornerRadius: layer.cornerRadius).cgPath
        context.addPath(roundedRectPath)
        context.fillPath()

        context.restoreGState()
        
        drawText(text: timeText, rect: rectForText, withAttributes: drawAttributes)
    }

    // 주어진 텍스트를 특정 위치에 그림
    private func drawText(text: String, rect: CGRect, withAttributes attributes: [NSAttributedString.Key: Any]? = nil) {
        // 텍스트 실제크기 계산
        let textSize = text.size(withAttributes: attributes)
        
        // 텍스트를 중앙에 배치하기 위한 새로운 CGRect 계산
        let centeredRect = CGRect(
            x: rect.origin.x + (rect.size.width - textSize.width) / 2,
            y: rect.origin.y + (rect.size.height - textSize.height) / 2,
            width: textSize.width,
            height: textSize.height
        )
        
        // 계산된 위치에 텍스트 그리기
        text.draw(in: centeredRect, withAttributes: attributes)
    }
}
