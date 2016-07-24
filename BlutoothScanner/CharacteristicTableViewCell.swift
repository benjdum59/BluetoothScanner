//
//  TableViewCell.swift
//  BlutoothScanner
//
//  Created by Benjamin Dumont on 24/07/2016.
//  Copyright © 2016 Bdumont. All rights reserved.
//

import UIKit
import CoreBluetooth

class CharacteristicTableViewCell: UITableViewCell {
    //<CBCharacteristic: 0x17ea52d0, UUID = Manufacturer Name String, properties = 0x2, value = (null), notifying = NO>
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var notifyingLabel: UILabel!
    
    var characteristic : CBCharacteristic! {
        didSet {
            self.uuidLabel.text = String(format:"UUID: %@", characteristic.UUID.UUIDString)
            self.notifyingLabel.text = String(format: "Notifying: %@", characteristic.isNotifying.toString())
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
