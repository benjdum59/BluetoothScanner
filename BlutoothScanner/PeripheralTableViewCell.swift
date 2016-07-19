//
//  PeripheralTableViewCell.swift
//  BlutoothScanner
//
//  Created by Benjamin Dumont on 19/07/2016.
//  Copyright © 2016 Bdumont. All rights reserved.
//

import UIKit
import CoreBluetooth

class PeripheralTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    
    var peripheral : CBPeripheral! {
        didSet {
            name.text = peripheral.name
            status.text = peripheral.state == .Connected ? "Connected" : "Not Connected"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
