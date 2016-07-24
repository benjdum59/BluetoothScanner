//
//  ServiceTableViewCell.swift
//  BlutoothScanner
//
//  Created by Benjamin Dumont on 24/07/2016.
//  Copyright © 2016 Bdumont. All rights reserved.
//

import UIKit
import CoreBluetooth

protocol ServiceTableViewCellDelegate : class {
    func showInfoTapped(service: CBService)
}

class ServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var informationButton: UIButton!
    @IBOutlet weak var primaryServiceLabel: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    
    weak var delegate : ServiceTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Init UI
    var service : CBService! {
        didSet {
            self.uuidLabel.text = service.UUID.UUIDString
            self.primaryServiceLabel.text = String(format: "Primary service: %@", service.isPrimary.toString())
            self.informationButton.hidden = service.characteristics == nil
        }
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func informationTapped(sender: UIButton) {
        delegate?.showInfoTapped(service)
    }
}
