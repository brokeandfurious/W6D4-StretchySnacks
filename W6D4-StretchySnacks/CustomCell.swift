//
//  CustomCell.swift
//  W6D4-StretchySnacks
//
//  Created by Murat Ekrem Kolcalar on 12/7/17.
//  Copyright © 2017 murtilicious. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var snackLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
