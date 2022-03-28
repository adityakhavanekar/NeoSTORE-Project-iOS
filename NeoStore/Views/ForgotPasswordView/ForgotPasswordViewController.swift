//
//  ForgotPasswordViewController.swift
//  NeoStore
//
//  Created by Neosoft on 06/01/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var ForgotPassSubmitBtn: UIButton!
    @IBOutlet weak var ForgotPassEmail: UITextField!
    var uifuncs = UIFuncs()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uifuncs.btnCornerRadius(UIButton: ForgotPassSubmitBtn)
        
    }
    
    
    @IBAction func ForgotPassSubmitBtnClicked(_ sender: UIButton) {
        guard let url = URL(string: "http://staging.php-dev.in:8844/trainingapp/api/users/forgot")else{return}
        let body : [String:Any] = [
            "email":"\(ForgotPassEmail.text!)"
        ]
        ApiService.callPost(url: url, params: body, finish: finishForgotPass)
    }
    func finishForgotPass (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
            {
                let parsedData = try JSONDecoder().decode(forgotPassResponse.self, from: jsonData)
                print(parsedData.status)
                print(parsedData.message)
                print(parsedData.user_msg)
                DispatchQueue.main.async {
                    self.showAlert(message: parsedData.user_msg, title: parsedData.message)
                    self.navigationController?.popViewController(animated: true)
                    
                }
                
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
    
    //MARK:- Alert Box
    func showAlert(message:String,title:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {action in
            print("tapped Ok")
        }))
        present(alert, animated: true, completion: nil)
    }
}
