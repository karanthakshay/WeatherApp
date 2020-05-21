//
//  ForcastTableViewCell.swift
//  WeatherApp
//
//  Created by Akshay A Karanth - (Digital) on 21/05/20.
//  Copyright © 2020 Akshay A Karanth - (Digital). All rights reserved.
//

import UIKit

class ForcastTableViewCell: UITableViewCell {
    @IBOutlet weak var weatherMainLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
