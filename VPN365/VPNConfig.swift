//
//  VPNConfig.swift
//  SafariView+vpn
//
//  Created by MPro3.1 on 26.01.2022.
//

import Foundation
import CoreVPN
class VPNConfig {
    static let shared = VPNConfig()
    var corevpnServers: CoreVPNServerModel?
    var corevpn: CoreVPN?
    private init(){}
    
    
}

extension VPNConfig: CoreVPNDelegate {
    func serverChanged(server: CoreVPNServerModel) {}
    
    func connenctionTimeChanged(time: String) {}
    
    func connectionStateChanged(state: CoreVPNConnectionState) {
        switch state {
        case .connected:
            print("Connected")
        case .connecting:
            print("Connecting")
        case .disconnected:
            print("Disconnected")
        case .disconnecting:
            print("Connecting")
        }
    }
}
