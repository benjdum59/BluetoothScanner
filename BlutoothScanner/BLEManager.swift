//
//  BLEManager.swift
//  BlutoothScanner
//
//  Created by Benjamin Dumont on 15/07/2016.
//  Copyright © 2016 Bdumont. All rights reserved.
//

import Foundation
import CoreBluetooth

class BLEManager{
    var centralManager : CBCentralManager!
    var bleHandler : BLEHandler
    init () {
        self.bleHandler = BLEHandler()
        self.centralManager = CBCentralManager(delegate: self.bleHandler, queue: nil)
    }
    
    
}
