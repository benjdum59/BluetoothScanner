//
//  BLEHandler.swift
//  BlutoothScanner
//
//  Created by Benjamin Dumont on 15/07/2016.
//  Copyright © 2016 Bdumont. All rights reserved.
//

import Foundation
import CoreBluetooth

class BLEHandler : NSObject, CBCentralManagerDelegate {
    override init(){
        super.init()
    }
    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch (central.state) {
        case .Unsupported:
            print("Unsupported")
        case .Unauthorized:
            print("Unauthorized")
        case .Unknown:
            print("Unknown")
        case .Resetting:
            print("Resetting")
        case .PoweredOff:
            print("PoweredOff")
        case .PoweredOn:
            print("BLE is Powered on!")
            print("Start scanning")
            central.scanForPeripheralsWithServices(nil, options: nil)
        }
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print(peripheral.name)
    }
    
    
    
    //    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
    //        print(peripheral.name)
    //    }
}
