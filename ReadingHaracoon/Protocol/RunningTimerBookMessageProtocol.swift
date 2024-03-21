//
//  RunningTimerBookMessageProtocol.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/21/24.
//

import UIKit

protocol RunningTimerBookMessageProtocol {
    func runningTimerBookMessageReceived(message: String)
}

extension BaseViewController: RunningTimerBookMessageProtocol {
    func runningTimerBookMessageReceived(message: String) {
        showToast(message: message)
    }
}
