//
//  OrderIdCell.swift
//  NeoStore
//
//  Created by Neosoft on 21/12/21.
//

import UIKit

class OrderIdCell: UITableViewCell {

    @IBOutlet weak var OrderIdProductName: UILabel!
    @IBOutlet weak var OrderIdProductCategory: UILabel!
    @IBOutlet weak var OrderIdProductQuantity: UILabel!
    @IBOutlet weak var OrderIdPrice: UILabel!
    @IBOutlet weak var OrderIdProdImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
