//
//  cityCell.swift
//  Ozweather
//
//  Created by Admin on 4/8/18.
//  Copyright © 2018 Olga Dalton. All rights reserved.
//

import UIKit

class cityCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var cond: UILabel!
    @IBOutlet weak var minmax: UILabel!
    @IBOutlet weak var temp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
