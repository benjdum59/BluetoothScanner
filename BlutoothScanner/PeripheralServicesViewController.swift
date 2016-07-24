//
//  PeripheralServicesViewController.swift
//  BlutoothScanner
//
//  Created by Benjamin Dumont on 24/07/2016.
//  Copyright © 2016 Bdumont. All rights reserved.
//

import UIKit
import CoreBluetooth


class PeripheralServicesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var isPrimaryLabel: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    
    var peripheral: CBPeripheral!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripheral.services?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("serviceCell")
        (cell as! ServiceTableViewCell).service = peripheral.services![indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return peripheral.name ?? peripheral.identifier.UUIDString
        }
        return ""
    }
}
