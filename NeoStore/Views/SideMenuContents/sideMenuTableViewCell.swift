//
//  sideMenuTableViewCell.swift
//  NeoStore
//
//  Created by Neosoft on 09/12/21.
//

import UIKit

class sideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var firstImageViewCell: UIImageView!
    @IBOutlet weak var sideMenuCellLbl: UILabel!
        
    @IBOutlet weak var cartCountNumberLbl: UILabel!
    @IBOutlet weak var cartCount: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        cartCount.layer.cornerRadius = cartCount.frame.height/2
        cartCount.clipsToBounds = true

        // Configure the view for the selected state
    }
    
}
