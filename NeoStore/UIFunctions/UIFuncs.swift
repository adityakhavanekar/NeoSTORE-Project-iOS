//
//  setImageToTextField.swift
//  NeoStore
//
//  Created by Neosoft on 03/12/21.
//

import Foundation
import UIKit
import SideMenu

extension UIImageView{
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit){
        contentMode = mode
        URLSession.shared.dataTask(with: url){ data,response,error in
            guard let httpURLResponse = response as?
                    HTTPURLResponse, httpURLResponse.statusCode == 200, let mimeType = response?.mimeType,mimeType.hasPrefix("image"),
            let data = data, error == nil, let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {[weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link:String, contentMode mode:ContentMode = .scaleAspectFit){
        guard let url = URL(string: link) else {return}
        downloaded(from: url, contentMode: mode)
    }
}

class UIFuncs{
    
    var menu:SideMenuNavigationController?
    
    // Set Image to Text Fields
    func setImageToTxtFields(image: UIImage, txtField:UITextField, placeHolder:String){
        let imageIcon = UIImageView()
        imageIcon.image = image
        
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        
        contentView.frame = CGRect(x:0, y: 0, width:image.size.width+20, height: image.size.height)
        imageIcon.frame = CGRect(x:10,y:0,width: image.size.width,height: image.size.height)
        
        txtField.leftView = contentView
        txtField.leftViewMode = .always
        txtField.clearButtonMode = .whileEditing
        txtField.textColor = .white
        txtField.layer.borderWidth = 1.0
        txtField.layer.borderColor = UIColor.white.cgColor
        txtField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    //Make Button Rounded Corners
    func btnCornerRadius(UIButton:UIButton){
        UIButton.layer.cornerRadius = 5
    }
    
    // Radio Buttons for Selection
    func radioBtn(firstButton:UIButton,secondButton:UIButton){
        if firstButton.isSelected == true{
            secondButton.isSelected = false
        }
        else{
            firstButton.isSelected = true
            secondButton.isSelected = false
        }
    }
    
    //Check Button
    func checkedBtn(button:UIButton){
        if button.isSelected == true{
            button.isSelected = false
        }
        else{
            button.isSelected = true
        }
    }
    
    //Slider Menu
    func SideMenu(view:UIView){
        menu = SideMenuNavigationController(rootViewController: SideViewController())
        menu?.leftSide = true
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        SideMenuManager.default.leftMenuNavigationController = menu
        menu?.menuWidth = 300
    }
    
    func showAlert(message:String,title:String,view:UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {action in
            print("tapped Ok")
            
        }))
        view.present(alert, animated: true, completion: nil)
    }
}
