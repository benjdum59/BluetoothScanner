//
//  PeripheralServicesViewController.swift
//  BlutoothScanner
//
//  Created by Benjamin Dumont on 24/07/2016.
//  Copyright © 2016 Bdumont. All rights reserved.
//

import UIKit
import CoreBluetooth


class PeripheralServicesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CBPeripheralDelegate, ServiceTableViewCellDelegate {
    
    @IBOutlet weak var serviceTableView: UITableView!
    @IBOutlet weak var isPrimaryLabel: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    
    var peripheral: CBPeripheral! {
        didSet {
            peripheral.delegate = self
            for service in peripheral.services! {
                peripheral.discoverCharacteristics(nil, forService: service)
            }
        }
    }
    
    var currentService : CBService!
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        serviceTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripheral.services?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("serviceCell")
        (cell as! ServiceTableViewCell).service = peripheral.services![indexPath.row]
        (cell as! ServiceTableViewCell).delegate = self
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return peripheral.name ?? peripheral.identifier.UUIDString
        }
        return ""
    }
    
    func showInfoTapped(service: CBService) {
        currentService = service
        performSegueWithIdentifier("showCharacteristics", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCharacteristics" {
            let destVC = segue.destinationViewController as! CharacteristicViewController
            destVC.characteristics = currentService.characteristics
        }
    }
    
    
}
