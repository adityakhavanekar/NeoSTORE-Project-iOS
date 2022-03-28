//
//  SideMenuHeaderCell.swift
//  NeoStore
//
//  Created by Neosoft on 09/12/21.
//

import UIKit

class SideMenuHeaderCell: UITableViewCell {
    
    
    @IBOutlet weak var sideHeaderImgView: UIImageView!
    @IBOutlet weak var sideHeaderNameLbl: UILabel!
    @IBOutlet weak var sideHeaderEmailLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sideHeaderImgView.layer.cornerRadius = sideHeaderImgView.frame.height/2
        sideHeaderImgView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
