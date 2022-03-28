//
//  RegisterView.swift
//  NeoStore
//
//  Created by Neosoft on 03/12/21.
//

import UIKit

class RegisterView: UIViewController {
    //MARK:- Variable Declaration
    //View Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    //TexField Outlets
    @IBOutlet weak var fnameTxtField: UITextField!
    @IBOutlet weak var lnameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var cpassTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    
    //Button outlets
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    //Keyboard Expand Variable
    var isExpand : Bool = false
    
    //uifunc class instance
    let Uifuncs = UIFuncs()
    let placeHolder = PlaceHolders()
    
    //MARK:- View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Radio Button AutoSelect
        self.maleBtn.isSelected = true
        
        //Hide keyboard when touched outside
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //Scroll When Keyboard Appear
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Set Images to Text Fields
        Uifuncs.setImageToTxtFields(image: UIImage(named: "username_icon")!, txtField: fnameTxtField, placeHolder: placeHolder.firstName)
        Uifuncs.setImageToTxtFields(image: UIImage(named:"username_icon")!, txtField: lnameTxtField, placeHolder: placeHolder.lastName)
        Uifuncs.setImageToTxtFields(image: UIImage(named:"email_icon")!, txtField: emailTxtField, placeHolder: placeHolder.eMail)
        Uifuncs.setImageToTxtFields(image: UIImage(named: "password_icon")!, txtField: passTxtField, placeHolder: placeHolder.password)
        Uifuncs.setImageToTxtFields(image: UIImage(named:"password_icon")!, txtField: cpassTxtField, placeHolder: placeHolder.confirmPass)
        Uifuncs.setImageToTxtFields(image: UIImage(named:"cellphone")!, txtField: phoneTxtField, placeHolder: placeHolder.phone)
        
        // Make Corners of button Round
        Uifuncs.btnCornerRadius(UIButton: registerBtn)
    }
    
    //MARK:- Scroll When Keyboard Appear Funcs
    @objc func keyboardAppear(){
        print("Expand False")
        if !isExpand{
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+300)
            isExpand = true
        }
    }
    @objc func keyboardDisappear(){
        print("Expand True")
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height-300)
        isExpand = false
    }
    //MARK:- Keyboard Dissappear when touch outside
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    //MARK:- Button Actions
    @IBAction func maleBtnClicked(_ sender: UIButton) {
        Uifuncs.radioBtn(firstButton: maleBtn, secondButton: femaleBtn)
    }
    @IBAction func femaleBtnClicked(_ sender: UIButton) {
        Uifuncs.radioBtn(firstButton: femaleBtn, secondButton: maleBtn)
    }
    @IBAction func agreeClicked(_ sender: UIButton) {
        Uifuncs.checkedBtn(button: agreeBtn)
    }
    
    //MARK:- SUBMIT BUTTON CLICKED
    @IBAction func RegisterBtnClicked(_ sender: UIButton) {
        //Validation
        if (fnameTxtField.text?.isValidName)!{
            print("name Valid")
        }else{
            showAlert(message: "Invalid Name",title: "Error")
        }
        if (lnameTxtField.text?.isValidName)!{
            print("l name Valid")
        }else{
            showAlert(message: "Invalid Last Name",title: "Error")
        }
        if (emailTxtField.text?.isValidEmail)!{
            print("email Valid")
        }else{
            showAlert(message: "Invalid Email",title: "Error")
        }
        if(passTxtField.text?.isValidPassword)!{
            print("Valid Pass")
        }else{
            showAlert(message: "Invalid Password",title: "Error")
        }
        if(cpassTxtField.text!==passTxtField.text!){
            print("Password Match")
        }else{
            showAlert(message: "Password does not match",title: "Error")
        }
        if(phoneTxtField.text?.isValidPhone)!{
            print("Valid Phone Number")
        }else{
            showAlert(message: "Invalid Phone Number",title:"Error")
        }
        if agreeBtn.isSelected == false{
            showAlert(message: "please agree terms and conditions",title: "Error")
        }
        
        //all Validations
        if(fnameTxtField.text?.isValidName)! && (lnameTxtField.text?.isValidName)! && (emailTxtField.text?.isValidEmail)! && (passTxtField.text?.isValidPassword)! && (cpassTxtField.text!==passTxtField.text!) && (phoneTxtField.text?.isValidPhone)! && agreeBtn.isSelected==true{
            print("All Validated")
            var gender = ""
            if maleBtn.isSelected == true{
                gender = "Male"
            }else if femaleBtn.isSelected == true{
                gender = "Female"
            }
            // Calling Api
            guard let url = URL(string: "http://staging.php-dev.in:8844/trainingapp/api/users/register")else{return}
            let body:[String:Any] = [
                "first_name":"\(fnameTxtField.text!)",
                "last_name":"\(lnameTxtField.text!)",
                "email":"\(emailTxtField.text!)",
                "password":"\(passTxtField.text!)",
                "confirm_password":"\(cpassTxtField.text!)",
                "gender":gender,
                "phone_no":Int(phoneTxtField.text!)!
            ]
            ApiService.callPost(url: url, params: body, finish: finishRegisterPost)
        }
    }
    
    //MARK:- Finish Register Post
    var responseRegisterData = [RegisterResponseData]()
    func finishRegisterPost (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
            {
                let parsedData = try JSONDecoder().decode(RegisterResponse.self, from: jsonData)
                
               let responseRegisterData = [parsedData.data]
               print("Status is : \(parsedData.status)")
               print(responseRegisterData)
               DispatchQueue.main.async{
                self.showAlert(message: "Registration Successful",title: "Success")
                self.fnameTxtField.text = ""
                self.lnameTxtField.text = ""
                self.emailTxtField.text = ""
                self.passTxtField.text = ""
                self.cpassTxtField.text = ""
                self.phoneTxtField.text = ""
                self.agreeBtn.isSelected = false
               }
            }
        }
        catch
        {
            print("Parse Error: \(error)")
            DispatchQueue.main.async {
                self.showAlert(message: "Email Id Already Exists",title: "Failure")
            }
            
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

//MARK:- Extension for Validation
extension String{
    var isValidEmail:Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    var isValidName:Bool{
        let nameRegEx = "[A-Za-z]{3,}"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }
    var isValidPassword:Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: self)
    }
    var isValidPhone:Bool{
        let phoneRegEx = "[0-9]{10}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }
}
