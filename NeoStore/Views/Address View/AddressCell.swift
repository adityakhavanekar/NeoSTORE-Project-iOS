//
//  AddressCell.swift
//  NeoStore
//
//  Created by Neosoft on 21/12/21.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet weak var addressNameLbl: UILabel!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var addressListSelectBtn: UIImageView!
    @IBOutlet weak var addressDeleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addressListSelectBtn.layer.cornerRadius = addressListSelectBtn.frame.height/2
        addressListSelectBtn.clipsToBounds = true
        addressListSelectBtn.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
