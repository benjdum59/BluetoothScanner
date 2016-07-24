//
//  ViewController.swift
//  BlutoothScanner
//
//  Created by Benjamin Dumont on 15/07/2016.
//  Copyright © 2016 Bdumont. All rights reserved.
//

import UIKit
import CoreBluetooth

class PeripheralListViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate, UITableViewDelegate, UITableViewDataSource, PeripheralTableViewCellDelegate {
    private var centralManager : CBCentralManager!
    let kSecondsToWait : Int64 = 60
    private var peripherals : [CBPeripheral] = []
    @IBOutlet weak var deviceTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var showInformations = false
    private var selectedPeripheral : CBPeripheral?
    private var numberCharacteristics : Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activityIndicator.stopAnimating()
        showInformations = false
        centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue())
        centralManager.delegate = self
        //Make central manager accessible for all classes
//        dataManager.centralManager = centralManager
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        showInformations = false
        numberCharacteristics = 0
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
        cell.delegate = self
        return cell
    }
    
    func showInfoTapped(peripheral: CBPeripheral) {
        self.showInformations = true
        self.centralManager.connectPeripheral(peripheral, options: nil)
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
            refreshDevices()
        }
        
    }
    
    
    
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print("didDiscoverPeripheral")
        peripheral.delegate = self
        peripherals.append(peripheral)
        deviceTableView.reloadData()
        
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("didConnectPeripheral")
        if (showInformations) {
            peripheral.discoverServices(nil)
        }
        self.deviceTableView.reloadData()
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        print("didDiscoverServices")
        for service in peripheral.services! {
            peripheral.discoverCharacteristics(nil, forService: service)
        }
        if showInformations {
            self.selectedPeripheral = peripheral
            self.performSegueWithIdentifier("showServices", sender: self)
        }
        
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        print("didDiscoverCharacteristicsForService")
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        print("didUpdateValueForCharacteristic")
        
    }
    
    @IBAction func refreshTapped(sender: UIBarButtonItem) {
        peripherals = []
        deviceTableView.reloadData()
        refreshDevices()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard peripherals[indexPath.row].state == .Connected else {
            self.centralManager.connectPeripheral(peripherals[indexPath.row], options: nil)
            return
        }
        self.centralManager.cancelPeripheralConnection(peripherals[indexPath.row])
        deviceTableView.reloadData()
    }
    
    private func refreshDevices(){
        self.centralManager.stopScan()
        activityIndicator.startAnimating()
        let options = [CBCentralManagerScanOptionAllowDuplicatesKey : 0]
        print("Start SCanning")
        centralManager.scanForPeripheralsWithServices(nil, options: options)

        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), kSecondsToWait * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            print("Stop Scanning")
            self.centralManager.stopScan()
            self.activityIndicator.stopAnimating()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showServices" {
            let destVC = segue.destinationViewController as! PeripheralServicesViewController
            destVC.peripheral = selectedPeripheral
            dataManager.selectedPerpheral = selectedPeripheral
        }
    }
}

