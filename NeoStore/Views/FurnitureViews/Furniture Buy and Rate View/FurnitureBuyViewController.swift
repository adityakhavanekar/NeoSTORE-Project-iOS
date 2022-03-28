//
//  FurnitureBuyViewController.swift
//  NeoStore
//
//  Created by Neosoft on 17/12/21.
//

import UIKit

class FurnitureBuyViewController: UIViewController {
    
    var uifuncs = UIFuncs()
    
    @IBOutlet weak var buyViewImgView: UIImageView!
    @IBOutlet weak var buyViewNameLbl: UILabel!
    
    @IBOutlet weak var buyViewPopView: UIView!
    @IBOutlet weak var buyViewBuyBtn: UIButton!
    
    @IBOutlet weak var buyViewQuantityTxtField: UITextField!
    var buyImageLink: String = ""
    var buyNameLbl:String = ""
    
    var buyProdId:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buyViewPopView.layer.cornerRadius = 10
        buyViewImgView.downloaded(from: buyImageLink)
        
        buyViewNameLbl.text = buyNameLbl
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        uifuncs.btnCornerRadius(UIButton: buyViewBuyBtn)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }

    @IBAction func BuyButtonClicked(_ sender: UIButton) {
        let userAcessToken = UserDefaults.standard.string(forKey: "userAcessToken")as Any
        guard let url = URL(string: "http://staging.php-dev.in:8844/trainingapp/api/addToCart")else{return}
        let body:[String:Any] = [
            "product_id":"\(buyProdId!)",
            "quantity":"\(buyViewQuantityTxtField.text!)"
        ]
        ApiServiceUpdateUserDetails.callPost(url: url, access_token: userAcessToken as! String, params: body, finish: finishAddToCart)
    }
    
    var addToCartRes = [AddToCartResponse]()
    func finishAddToCart (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
            {
                let parsedData = try JSONDecoder().decode(AddToCartResponse.self, from: jsonData)
                print("Status is : \(parsedData.status)")
                print(parsedData.message)
                print(parsedData.user_msg)
                print(parsedData.status)
                print(parsedData.total_carts)
                
                DispatchQueue.main.async {
                    self.uifuncs.showAlert(message: parsedData.user_msg, title: parsedData.message, view: self)
                }
               }
        }
        catch
        {
            print("Parse Error: \(error)")
            DispatchQueue.main.async {
                self.uifuncs.showAlert(message: "Quantity Should Be Between 1-8", title: "Insert Valid Quantity", view: self)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
