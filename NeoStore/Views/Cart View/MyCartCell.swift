//
//  MyCartCell.swift
//  NeoStore
//
//  Created by Neosoft on 20/12/21.
//

import UIKit
import iOSDropDown

class MyCartCell: UITableViewCell {
    
    

    @IBOutlet weak var myCartCellImgView: UIImageView!
    
    
    
    @IBOutlet weak var myCartCellQuantityLbl: UITextField!
    @IBOutlet weak var myCartCellLbl: UILabel!
    @IBOutlet weak var myCartCellLbl2: UILabel!
    @IBOutlet weak var myCartCostLbl: UILabel!
    
    let userAccessToken = UserDefaults.standard.string(forKey: "userAcessToken")as Any
    var prodId : Int = 0
    var prodQuantity:Int = 0
    let url = URL(string: "http://staging.php-dev.in:8844/trainingapp/api/editCart")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myCartCellImgView.backgroundColor = .red
        myCartCellLbl.text = "Hello"
            
    }
    
    @IBAction func addQuantityClicked(_ sender: UIButton) {
        print(myCartCellQuantityLbl.text!)
        if prodQuantity<8 {
            prodQuantity = prodQuantity+1
            let body:[String:Any] = [
                "product_id":"\(self.prodId)",
                "quantity":"\(self.prodQuantity)"
            ]
            ApiServiceUpdateUserDetails.callPost(url: url!, access_token: userAccessToken as! String, params: body, finish: finishAddToCart)
        }
    }
    
    @IBAction func subtractQuantityClicked(_ sender: UIButton) {
        print(myCartCellQuantityLbl.text!)
       
        if prodQuantity>1 {
            prodQuantity = prodQuantity-1
            let body:[String:Any] = [
                "product_id":"\(self.prodId)",
                "quantity":"\(prodQuantity)"
            ]
            ApiServiceUpdateUserDetails.callPost(url: url!, access_token: userAccessToken as! String, params: body, finish: finishAddToCart)
        }
    }
    
    func finishAddToCart (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
            {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name("CartEdited"), object: nil)
                }
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
}
