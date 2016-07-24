//
//  PeripheralTableViewCell.swift
//  BlutoothScanner
//
//  Created by Benjamin Dumont on 19/07/2016.
//  Copyright © 2016 Bdumont. All rights reserved.
//

import UIKit
import CoreBluetooth

protocol PeripheralTableViewCellDelegate : class {
    func showInfoTapped(peripheral: CBPeripheral)
}

class PeripheralTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    weak var delegate : PeripheralTableViewCellDelegate?
    
    /// Init UI
    var peripheral : CBPeripheral! {
        didSet {
            name.text = peripheral.name ?? peripheral.identifier.UUIDString
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
    @IBAction func showInfoTapped(sender: UIButton) {
        delegate?.showInfoTapped(peripheral)
    }
}
