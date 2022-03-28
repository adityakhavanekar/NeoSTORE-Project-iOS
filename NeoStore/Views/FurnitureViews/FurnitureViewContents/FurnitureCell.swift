//
//  FurnitureCell.swift
//  NeoStore
//
//  Created by Neosoft on 12/12/21.
//

import UIKit

class FurnitureCell: UITableViewCell {

    @IBOutlet weak var furImgView: UIImageView!
    @IBOutlet weak var furNameLbl: UILabel!
    @IBOutlet weak var furDescLbl: UILabel!
    @IBOutlet weak var furCostLbl: UILabel!
    @IBOutlet weak var furRatingImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
