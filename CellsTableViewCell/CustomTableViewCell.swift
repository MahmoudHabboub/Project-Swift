//
//  CustomTableViewCell.swift
//  MyProject
//
//  Created by محمود محمد on 12/9/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var View_TableViewCell: UIView!
    @IBOutlet weak var Coins_ImageView: UIImageView!
    @IBOutlet weak var TitleCoins_Label: UILabel!
    @IBOutlet weak var Date_Label: UILabel!
    @IBOutlet weak var ValueCoins_Label: UILabel!
    @IBOutlet weak var Arrow_ImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
