//
//  AddAddressViewController.swift
//  NeoStore
//
//  Created by Neosoft on 21/12/21.
//

import UIKit

class AddAddressViewController: UIViewController {

    var uifuncs = UIFuncs()
    @IBOutlet weak var SaveAddressBtn: UIButton!
    @IBOutlet weak var addAddressTextView: UITextView!
    @IBOutlet weak var addAddressCity: UITextField!
    @IBOutlet weak var addAddressCity2: UITextField!
    @IBOutlet weak var addAddressZipCode: UITextField!
    @IBOutlet weak var addAddressState: UITextField!
    @IBOutlet weak var addAddressCountry: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Address"
        
        uifuncs.btnCornerRadius(UIButton: SaveAddressBtn)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func SaveAddress(_ sender: UIButton) {
        if addAddressCity.text! != "" && addAddressTextView.text! != "" && addAddressCity2.text! != "" && addAddressState.text! != "" && addAddressZipCode.text! != "" && addAddressState.text! != "" && addAddressCountry.text! != ""
        {
            AddressLists.append(Address(AddressLbl: addAddressCity.text!, AddressText: "\(addAddressTextView.text!),\(addAddressCity2.text!),\(addAddressState.text!)\n\(addAddressCountry.text!)(\(addAddressZipCode.text!))"))
            uifuncs.showAlert(message: "Address Added Successfully", title: "Address Added", view: self)
            navigationController?.popViewController(animated: true)
        }
        else
        {
            print("Address is Invalid!. Enter Correct Address")
            uifuncs.showAlert(message: "Enter All Details", title: "Invalid Address", view: self)
        }
        
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
