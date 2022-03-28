//
//  ResetPassView.swift
//  NeoStore
//
//  Created by Neosoft on 12/12/21.
//

import UIKit

class ResetPassView: UIViewController {
    //MARK:- Variables Declarations
    // IBOutlets
    @IBOutlet weak var currentPassTxtField: UITextField!
    @IBOutlet weak var newPassTxtField: UITextField!
    @IBOutlet weak var cNewPassTxtField: UITextField!
    
    // Class Instances
    var uifuncs = UIFuncs()
    var placeHolder = PlaceHolders()
    var passwordChangeApi = ApiServicePostPassword()
    
    
    let userAcessToken = UserDefaults.standard.string(forKey: "userAcessToken")as Any
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Reset Password"
        
        uifuncs.setImageToTxtFields(image: UIImage(named:"password_icon")!, txtField: currentPassTxtField, placeHolder: placeHolder.currentPass)
        uifuncs.setImageToTxtFields(image: UIImage(named:"password_icon")!, txtField: newPassTxtField, placeHolder: placeHolder.newPass)
        uifuncs.setImageToTxtFields(image: UIImage(named:"password_icon")!, txtField:cNewPassTxtField, placeHolder: placeHolder.confirmPass)
        
    }
    
    @IBAction func ChangePasswordSubmitClicked(_ sender: UIButton) {
        guard let url = URL(string: "http://staging.php-dev.in:8844/trainingapp/api/users/change")else{return}
        print("BTn CLicked")
        
        
        let body:[String:Any] = [
            "old_password":"\(currentPassTxtField.text!)",
            "password":"\(newPassTxtField.text!)",
            "confirm_password":"\(cNewPassTxtField.text!)"
        ]
        ApiServicePostPassword.callPost(url: url, access_token: userAcessToken as! String, params: body, finish: finishPasswordChange)
    }
    
    var passResponseData = [PasswordResponse]()
    func finishPasswordChange (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
            {
                let parsedData = try JSONDecoder().decode(PasswordResponse.self, from: jsonData)
                print(parsedData.message)
                DispatchQueue.main.async {
                    self.uifuncs.showAlert(message: parsedData.user_msg, title: parsedData.message, view: self)
                }
            }
        }
        catch
        {
            print("Parse Error: \(error)")
            DispatchQueue.main.async {
                self.uifuncs.showAlert(message: "Error", title: "Error", view: self)
            }
        }
    }
}
