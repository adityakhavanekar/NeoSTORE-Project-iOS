//
//  myCartFooterCell.swift
//  NeoStore
//
//  Created by Neosoft on 02/01/22.
//

import UIKit

class myCartFooterCell: UITableViewCell {

    @IBOutlet weak var myCartTotalCostLbl: UILabel!
    var cost:String?
    override func awakeFromNib() {
        super.awakeFromNib()
        myCartTotalCostLbl.text = cost
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
