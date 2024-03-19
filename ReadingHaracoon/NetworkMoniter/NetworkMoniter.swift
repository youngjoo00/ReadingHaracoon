//
//  NetworkMoniter.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/20/24.
//

import Foundation
import Network

final class NetworkMonitor {
    private let queue = DispatchQueue.global(qos: .background)
    private let monitor: NWPathMonitor
    
    init() {
        monitor = NWPathMonitor()
        dump(monitor)
        print("------------")
    }
    
    func startMonitoring(statusUpdateHandler: @escaping (NWPath.Status) -> Void) {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                statusUpdateHandler(path.status)
            }
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
