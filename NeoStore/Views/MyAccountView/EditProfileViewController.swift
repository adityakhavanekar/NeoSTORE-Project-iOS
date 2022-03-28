//
//  EditProfileViewController.swift
//  NeoStore
//
//  Created by Neosoft on 10/12/21.
//

import UIKit
import Alamofire



class EditProfileViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    //MARK:- Variable Declarations
    
    // Class instances
    var uifuncs = UIFuncs()
    var placeHolder = PlaceHolders()
    
    let userAcessToken = UserDefaults.standard.string(forKey: "userAcessToken")!as String
    
    // IBOutlets
    @IBOutlet weak var internalView: UIView!
    @IBOutlet weak var editProfileScrollView: UIScrollView!
    @IBOutlet weak var editProfileImgView: UIImageView!
    @IBOutlet weak var editProfileFirstNameTxtField: UITextField!
    @IBOutlet weak var editProfileLastNameTxtField: UITextField!
    @IBOutlet weak var editProfileEmailTxtField: UITextField!
    @IBOutlet weak var editProfilePhoneTxtField: UITextField!
    @IBOutlet weak var editProfileDobTxtField: UITextField!
    @IBOutlet weak var editProfileSubmitBtn: UIButton!
    
    var selectedImage:UIImage?
    
    var apiUserData = APIProcessingUserDetails()
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        uifuncs.setImageToTxtFields(image: UIImage(named: "username_icon")!, txtField: editProfileFirstNameTxtField, placeHolder: placeHolder.firstName)
        uifuncs.setImageToTxtFields(image: UIImage(named:"username_icon")!, txtField: editProfileLastNameTxtField, placeHolder: placeHolder.lastName)
        uifuncs.setImageToTxtFields(image: UIImage(named:"email_icon")!, txtField: editProfileEmailTxtField, placeHolder: placeHolder.eMail)
        uifuncs.setImageToTxtFields(image: UIImage(named: "cellphone")!, txtField: editProfilePhoneTxtField, placeHolder: placeHolder.phone)
        uifuncs.setImageToTxtFields(image: UIImage(named: "dob_icon")!, txtField: editProfileDobTxtField, placeHolder: placeHolder.dob)
        
        uifuncs.btnCornerRadius(UIButton: editProfileSubmitBtn)
        
        editProfileImgView.layer.cornerRadius = editProfileImgView.frame.height/2
        editProfileImgView.clipsToBounds = true
        editProfileImgView.backgroundColor = .white
            
        editProfileScrollView.isScrollEnabled = true
        
        //TAP Gesture
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tappedGestureRecognizer:)))
        editProfileImgView.isUserInteractionEnabled = true
        editProfileImgView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //TAP Gesture Function
    @objc func imageTapped(tappedGestureRecognizer:UITapGestureRecognizer){
        //let tappedImage = tappedGestureRecognizer.view as! UIImage
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imageController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        editProfileImgView.image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        self.dismiss(animated: true, completion: nil)
        selectedImage = editProfileImgView.image
    }
    //MARK:- Submit Button Clicked
    @IBAction func editProfileSubmitClicked(_ sender: Any) {
         
        if(editProfileFirstNameTxtField.text?.isValidName)! && (editProfileLastNameTxtField.text?.isValidName)! && (editProfileEmailTxtField.text?.isValidEmail)! && (editProfilePhoneTxtField.text?.isValidPhone)! && (editProfileDobTxtField.text != "") && editProfileImgView.image != nil{
            uploadImage()
        }
        else{
            self.uifuncs.showAlert(message: "Fill all Details ", title: "All details required", view: self)
        }
    }
    // MARK:- ALAMOFIRE
    func uploadImage()
    {
      let image = selectedImage! //this is your image from gallery
      let imgData = convertImageToBase64String(img: image) //here i m covert it to base 64
      //Parameter HERE
        let params = ["first_name":"\(editProfileFirstNameTxtField.text!)",
                      "last_name":"\(editProfileLastNameTxtField.text!)",
                      "email":"\(editProfileEmailTxtField.text!)",
                      "dob":"\(editProfileDobTxtField.text!)",
                      "phone_no":"\(editProfilePhoneTxtField.text!)",
                    "profile_pic":imgData] //all params as string
      //Header HERE
      let headers = ["access_token" : "\(userAcessToken)"]
      Alamofire.upload(multipartFormData: { multipartFormData in
        for (key, value) in params
        {
          multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
        }
      }, usingThreshold:UInt64.init(),
      to: "http://staging.php-dev.in:8844/trainingapp/api/users/update", //URL
      method: .post,
      headers: headers,
      encodingCompletion: { (result) in
        switch result {
        case .success(let upload, _, _):
          print("the status code is :")
          upload.uploadProgress(closure: { (progress) in
              
              
            print("something")
          })
          upload.responseJSON { response in
            print("the resopnse code is : \(response.response?.statusCode)")
            print("the response is : \(response)")
            DispatchQueue.main.async {
                self.uifuncs.showAlert(message: "\(response.result)", title: "\(response.result)", view: self)
            }
          }
          break
        case .failure(let encodingError):
          print("the error is  : \(encodingError.localizedDescription)")
            DispatchQueue.main.async {
                self.uifuncs.showAlert(message: "Error In Uploading Data", title: "Error", view: self)
            }
          break
        }
      })
    }
    
    //MARK:-FUNC CONVERT BASE 64
    func convertImageToBase64String (img: UIImage) -> String {
        let baseStr = "data:image/jpeg;base64,\(img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? "")"
      return baseStr
    }
    
    //MARK:- ALERT BOX
    
}

extension Data{
    mutating func append(_ string:String){
        if let data = string.data(using: .utf8){
            append(data)
        }
        print(string)
    }
}
