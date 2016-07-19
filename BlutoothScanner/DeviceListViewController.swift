//
//  ViewController.swift
//  BlutoothScanner
//
//  Created by Benjamin Dumont on 15/07/2016.
//  Copyright © 2016 Bdumont. All rights reserved.
//

import UIKit
import CoreBluetooth

class DeviceListViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate, UITableViewDelegate, UITableViewDataSource {
    private var centralManager : CBCentralManager!
    let kSecondsToWait : Int64 = 10
    var peripherals : [CBPeripheral] = []
    @IBOutlet weak var deviceTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue())
        activityIndicator.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("peripheralCell") as! PeripheralTableViewCell
        cell.peripheral = peripherals[indexPath.row]
        return cell
    }
    
    dynamic func centralManagerDidUpdateState(central: CBCentralManager) {
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
            refreshDevices()
        }
        
    }
    
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        peripherals.append(peripheral)
        deviceTableView.reloadData()
        
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
    
    @IBAction func refreshTapped(sender: UIBarButtonItem) {
        peripherals = []
        deviceTableView.reloadData()
        refreshDevices()
    }
    
    private func refreshDevices(){
        print("Start scanning")
        activityIndicator.startAnimating()
        let options = [CBCentralManagerScanOptionAllowDuplicatesKey : 0]
        centralManager.scanForPeripheralsWithServices(nil, options: options)
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), kSecondsToWait * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            print("Stop Scanning")
            self.centralManager.stopScan()
            self.activityIndicator.stopAnimating()
        }
    }
    
    
}

