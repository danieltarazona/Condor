//
//  NetworkManager.swift
//  Core
//
//  Created by Daniel Tarazona on 5/19/21.
//

import Foundation
import Network

class NetworkManager {
    var offline: Bool = false

    var monitorWiFi = NWPathMonitor(requiredInterfaceType: .wifi)
    var monitorCellular = NWPathMonitor(requiredInterfaceType: .cellular)
    var queueWiFi = DispatchQueue(label: "WiFiMonitor")
    var queueCellular = DispatchQueue(label: "CellularMonitor")
    
    required init() {
        isConnected()
    }
    
    func isConnected() {
        monitorWiFi.pathUpdateHandler = { nwPath in
            if nwPath.status == .satisfied {
                self.offline = false
                print("WiFi Online")
                return
            }
        }
        
        monitorCellular.pathUpdateHandler = { nwPath in
            if nwPath.status == .satisfied {
                self.offline = false
                print("Cellular Online")
                return
            }
            
            self.monitorWiFi.start(queue: self.queueWiFi)
        }

        monitorCellular.start(queue: queueCellular)
    }
}
