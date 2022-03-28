//
//  ViewController.swift
//  NeoStore
//
//  Created by Neosoft on 03/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Varibale Declarations
    
    // UIOutlets
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var loginBtnOutlet: UIButton!
    @IBOutlet weak var RegisterPlusBtnOutlet: UIButton!
    @IBOutlet weak var forgotPassBtn: UIButton!
    
    // class instance for ui
    let Uifunc = UIFuncs()
    
    
    //MARK:- ViewDidLoad func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set images to text fields
        Uifunc.setImageToTxtFields(image: UIImage(named:"username_icon")!, txtField: userNameTxtField, placeHolder: "Username")
        Uifunc.setImageToTxtFields(image: UIImage(named:"password_icon")!, txtField: passTxtField, placeHolder: "Password")
        
        // Make Button corners Round
        Uifunc.btnCornerRadius(UIButton: loginBtnOutlet)
        userNameTxtField.text = "testp@gmail.com"
        passTxtField.text = "Test@123"
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    //MARK: - UIButtons Actions
    @IBAction func plusBtnClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let rv = sb.instantiateViewController(identifier: "RegisterView") as! RegisterView
        self.navigationController?.pushViewController(rv, animated: true)
    }
    
    @IBAction func forgotPassClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let fv = sb.instantiateViewController(identifier: "ForgotPasswordViewController")as! ForgotPasswordViewController
        self.navigationController?.pushViewController(fv, animated: true)
    }
    
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        /*let sb = UIStoryboard(name: "Main", bundle: nil)
        let hp = sb.instantiateViewController(identifier: "HomePage")as! HomePage
        self.navigationController?.pushViewController(hp, animated: true)*/
        // login url
        guard let loginUrl = URL(string: "http://staging.php-dev.in:8844/trainingapp/api/users/login")else{return}
        let body:[String:Any] = [
            "email":"\(userNameTxtField.text!)",
            "password":"\(passTxtField.text!)"
        ]
        ApiService.callPost(url: loginUrl, params: body, finish: finishLoginPost)
    }
    
    //MARK:- Finish Login Post
    var responseLoginData = [LoginResponseData]()
    func finishLoginPost (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
            {
                responseLoginData.removeAll()
                UserDefaults.standard.set("",forKey: "userAcessToken")
                let parsedData = try JSONDecoder().decode(LoginResponse.self, from: jsonData)
                
               let responseLoginData = [parsedData.data]
                UserDefaults.standard.set(responseLoginData[0].access_token,forKey: "userAcessToken")
                print(UserDefaults.standard.string(forKey: "userAcessToken")!as Any)
               print("Status is : \(parsedData.status)")
               print(responseLoginData)
                DispatchQueue.main.async {
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let hp = sb.instantiateViewController(identifier: "HomePage")as! HomePage
                    self.navigationController?.pushViewController(hp, animated: true)
                }
            }
        }
        catch
        {
            print("Parse Error: \(error)")
            DispatchQueue.main.async {
                self.showAlert(message: "Invalid Login Credentials",title: "Login Failed")
            }
            
        }
    }
    //MARK:- dismiss keyboard func
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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

