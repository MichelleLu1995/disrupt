//
//  TableViewCell.swift
//  UITest
//
//  Created by Annette Chen on 6/8/17.
//  Copyright © 2017 Annette Chen. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var deal: UILabel!
    @IBOutlet weak var distanceAway: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
