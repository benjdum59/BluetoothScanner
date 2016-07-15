//
//  ViewController.swift
//  BlutoothScanner
//
//  Created by Benjamin Dumont on 15/07/2016.
//  Copyright © 2016 Bdumont. All rights reserved.
//

import UIKit
import CoreBluetooth

class DeviceListViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    var centralManager : CBCentralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        print("1")
        
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("1")
        
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        print("1")
        
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        print("1")
        
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        print("1")
        
    }
    
    
}

