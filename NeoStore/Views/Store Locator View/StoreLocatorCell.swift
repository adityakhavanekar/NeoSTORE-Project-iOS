//
//  StoreLocatorCell.swift
//  NeoStore
//
//  Created by Neosoft on 21/12/21.
//

import UIKit

class StoreLocatorCell: UITableViewCell {

    
    @IBOutlet weak var storeLocatorStoreName: UILabel!
    @IBOutlet weak var storeLocatorStoreAddress: UILabel!
    @IBOutlet weak var storeLocatorIconImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
