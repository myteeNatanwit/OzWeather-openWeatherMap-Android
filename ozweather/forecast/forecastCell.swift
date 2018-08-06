//
//  forecastCell.swift
//  Ozweather
//
//  Created by Admin on 5/8/18.
//

import UIKit

class forecastCell: UITableViewCell {

    @IBOutlet weak var theDT: UILabel!
    @IBOutlet weak var cond: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var minmax: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
