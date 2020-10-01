//
//  CustomCollectionViewCell.swift
//  MyProject
//
//  Created by محمود محمد on 12/9/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var View_Cell: UIView!
    @IBOutlet weak var Circle_ImageView: UIImageView!
    @IBOutlet weak var Title_Label: UILabel!
    @IBOutlet weak var SubTitle_Label: UILabel!
    @IBOutlet weak var Value_Label: UILabel!
    @IBOutlet weak var VarValue_Label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //RoundingCornersToView_Cell
        let maskPath = UIBezierPath(roundedRect: View_Cell.bounds,
                                    byRoundingCorners: [.bottomLeft, .topLeft , .bottomRight, .topRight],
                                    cornerRadii: CGSize(width: 8.0, height: 8.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        View_Cell.layer.mask = shape
        
    }

}
