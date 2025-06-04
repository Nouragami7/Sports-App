//
//  NetworkMonitor.swift
//  Sports-App
//
//  Created by macOS on 04/06/2025.
//

import Foundation

import Network


class NetworkReachabilityManager {
    
    static let shared = NetworkReachabilityManager()
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkReachabilityMonitor")
    
    private(set) var isNetworkAvailable: Bool = false
    
    private init() {
        monitor = NWPathMonitor()
        startMonitoring()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            let isConnected = path.status == .satisfied
            self?.isNetworkAvailable = isConnected
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    deinit {
        stopMonitoring()
    }
}
