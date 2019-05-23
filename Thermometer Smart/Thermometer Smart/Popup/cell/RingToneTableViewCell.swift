//
//  RingToneTableViewCell.swift
//  Thermometer Smart
//
//  Created by MinhNT on 5/22/19.
//  Copyright © 2019 MinhNT. All rights reserved.
//

import UIKit

class RingToneTableViewCell: UITableViewCell {

    @IBOutlet weak var lbNameRings: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectRingTone(_ sender: Any) {
        self.selectRingTone?()
    }
    
    
    var selectRingTone:(()->())?
}

