//
//  DeviceTableViewCell.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/21/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        lbMac.text = ""
        lbMac.adjustsFontSizeToFitWidth()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var displayPeripheral: DisplayPeripheral? {
        didSet {
            self.lbName?.text =  "\(displayPeripheral!.name)"
            let kCBAdvDataManufacturerData = displayPeripheral?.advertisementData["kCBAdvDataManufacturerData"] as? Any
            let arrMac = Array(kCBAdvDataManufacturerData.debugDescription.replacingOccurrences(of: "Optional(Optional(<", with: "").replacingOccurrences(of: ">))", with: "").replacingOccurrences(of: " ", with: ""))
            var i:Int = 0;
            var strMac = ""
            for character in arrMac
            {
                strMac +=  String(character)
                i += 1
                if i%2 == 0 && i != arrMac.count
                {
                    strMac +=  ":"
                }
                
            }
            lbMac.text = strMac.uppercased()
        }
    }
    
    @IBAction func actionConnect(_ sender: Any) {
        connect?()
    }
    var connect:(()->())?
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbMac: UILabel!
    
}
