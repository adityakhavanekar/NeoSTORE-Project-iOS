//
//  MyAccountViewController.swift
//  NeoStore
//
//  Created by Neosoft on 10/12/21.
//

import UIKit

class MyAccountViewController: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var myAccountImgView: UIImageView!
    @IBOutlet weak var myAccountFirstName: UITextField!
    @IBOutlet weak var myAccountLastName: UITextField!
    @IBOutlet weak var myAccountMail: UITextField!
    @IBOutlet weak var myAccountPhone: UITextField!
    @IBOutlet weak var myAccountDob: UITextField!
    @IBOutlet weak var myAccountEditBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //class variables
    var uifuncs = UIFuncs()
    var views = Views()
    
    //API Variables
    var apiUserData = APIProcessingUserDetails()
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uifuncs.setImageToTxtFields(image: UIImage(named: "username_icon")!, txtField: myAccountFirstName, placeHolder: "")
        uifuncs.setImageToTxtFields(image: UIImage(named:"username_icon")!, txtField: myAccountLastName, placeHolder: "")
        uifuncs.setImageToTxtFields(image: UIImage(named:"email_icon")!, txtField: myAccountMail, placeHolder: "")
        uifuncs.setImageToTxtFields(image: UIImage(named: "cellphone")!, txtField: myAccountPhone, placeHolder: "")
        uifuncs.setImageToTxtFields(image: UIImage(named: "dob_icon")!, txtField: myAccountDob, placeHolder: "")
        
        //Calling GET Api function
        apiUserData.jsonParse(url: "http://staging.php-dev.in:8844/trainingapp/api/users/getUserData") { [self] in
            
            
            /*if let decodedData = Data(base64Encoded: apiUserData.userListData[0].profile_pic,options: .ignoreUnknownCharacters){
                let image = UIImage(data: decodedData)
                myAccountImgView.image = image
            }*/
            
            self.myAccountFirstName.text = "\(apiUserData.userListData[0].first_name)"
            self.myAccountLastName.text = "\(apiUserData.userListData[0].last_name)"
            if apiUserData.userListData[0].dob != nil {
                self.myAccountDob.text = "\(apiUserData.userListData[0].dob)"
            }
            if apiUserData.userListData[0].profile_pic != nil{
                self.myAccountImgView.downloaded(from: apiUserData.userListData[0].profile_pic!)
            }
            self.myAccountPhone.text = "\(String(apiUserData.userListData[0].phone_no))"
            self.myAccountMail.text = "\(apiUserData.userListData[0].email)"
            
            print(apiUserData.userListData)
            print(apiUserData.userListData[0])
        }
       
        
        // Make Corners of button Round
        uifuncs.btnCornerRadius(UIButton: myAccountEditBtn)
        
        myAccountImgView.layer.cornerRadius = myAccountImgView.frame.height/2
        myAccountImgView.clipsToBounds = true
        myAccountImgView.backgroundColor = .white
        
        myAccountDob.isEnabled = false
        myAccountMail.isEnabled = false
        myAccountPhone.isEnabled = false
        myAccountLastName.isEnabled = false
        myAccountFirstName.isEnabled = false
        
        scrollView.isScrollEnabled  = false
    }
    
    @IBAction func editProfileClicked(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let sv = sb.instantiateViewController(identifier: views.EditProfile)as! EditProfileViewController
        self.navigationController?.pushViewController(sv, animated: true)
    }
    
    @IBAction func resetPassClicked(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let sv = sb.instantiateViewController(identifier: views.ResetPassView)as! ResetPassView
        self.navigationController?.pushViewController(sv, animated: true)
    }
}
