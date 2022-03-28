//
//  MyOrdersCell.swift
//  NeoStore
//
//  Created by Neosoft on 21/12/21.
//

import UIKit

class MyOrdersCell: UITableViewCell {

    @IBOutlet weak var myOrdersCostLbl: UILabel!
    @IBOutlet weak var myOrdersOrderIdLbl: UILabel!
    @IBOutlet weak var myOrdersDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
