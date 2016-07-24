//
//  ServiceTableViewCell.swift
//  BlutoothScanner
//
//  Created by Benjamin Dumont on 24/07/2016.
//  Copyright © 2016 Bdumont. All rights reserved.
//

import UIKit
import CoreBluetooth

class ServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var primaryServiceLabel: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var service : CBService! {
        didSet {
            self.uuidLabel.text = service.UUID.UUIDString
            self.primaryServiceLabel.text = String(format: "Primary service: %@", service.isPrimary.toString())
        }
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}