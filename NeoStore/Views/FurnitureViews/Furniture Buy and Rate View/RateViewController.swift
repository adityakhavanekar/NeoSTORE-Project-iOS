//
//  RateViewController.swift
//  NeoStore
//
//  Created by Neosoft on 17/12/21.
//

import UIKit

class RateViewController: UIViewController {
    
    var uifuncs = UIFuncs()

    var selectedRating = 0
    var rateProdId : Int = 0
    
    @IBOutlet weak var starBtn1: UIButton!
    @IBOutlet weak var starBtn2: UIButton!
    @IBOutlet weak var starBtn3: UIButton!
    @IBOutlet weak var starBtn4: UIButton!
    @IBOutlet weak var starBtn5: UIButton!
    @IBOutlet weak var rateNowBtn: UIButton!
    
    @IBOutlet weak var ratePopView: UIView!
    
    @IBOutlet weak var rateViewLbl: UILabel!
    @IBOutlet weak var rateViewImgView: UIImageView!
    
    var rateImageLink : String = ""
    var rateNameLbl : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        uifuncs.btnCornerRadius(UIButton: rateNowBtn)
        ratePopView.layer.cornerRadius = 10
        
        rateViewLbl.text = rateNameLbl
        rateViewImgView.downloaded(from: rateImageLink)
        
        starBtn3.isSelected = true
        
    }
    
    @IBAction func starBtn1Clicked(_ sender: UIButton) {
        starBtn1.isSelected = true
        starBtn2.isSelected = false
        starBtn3.isSelected = false
        starBtn4.isSelected = false
        starBtn5.isSelected = false
        selectedRating = 1
    }
    
    @IBAction func starBtn2Clicked(_ sender: UIButton) {
        starBtn1.isSelected = true
        starBtn2.isSelected = true
        starBtn3.isSelected = false
        starBtn4.isSelected = false
        starBtn5.isSelected = false
        selectedRating = 2
    }
    
    @IBAction func starBtn3Clicked(_ sender: UIButton) {
        starBtn1.isSelected = true
        starBtn2.isSelected = true
        starBtn3.isSelected = true
        starBtn4.isSelected = false
        starBtn5.isSelected = false
        selectedRating = 3
    }
    
    @IBAction func starBtn4Clicked(_ sender: UIButton) {
        starBtn1.isSelected = true
        starBtn2.isSelected = true
        starBtn3.isSelected = true
        starBtn4.isSelected = true
        starBtn5.isSelected = false
        selectedRating = 4
    }
    
    @IBAction func starBtn5Clicked(_ sender: UIButton) {
        starBtn1.isSelected = true
        starBtn2.isSelected = true
        starBtn3.isSelected = true
        starBtn4.isSelected = true
        starBtn5.isSelected = true
        selectedRating = 5
    }
    
    @IBAction func rateNowClicked(_ sender: UIButton) {
        print("Prod:\(rateProdId),rating:\(selectedRating)")
        guard let url = URL(string: "http://staging.php-dev.in:8844/trainingapp/api/products/setRating")else{return}
        let body:[String:Any] = [
            "product_id":"\(rateProdId)",
            "rating":"\(selectedRating)"
        ]
        ApiService.callPost(url: url, params: body, finish: finishRatingPost)
    }
    var RatingResponse = [Rating]()
    func finishRatingPost (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
            {
                let parsedData = try JSONDecoder().decode(Rating.self, from: jsonData)
                print("Status is : \(parsedData.status)")
                print(parsedData.message)
                print(parsedData.user_msg)
                print(parsedData.status)
                DispatchQueue.main.async {
                    self.uifuncs.showAlert(message: parsedData.user_msg, title: parsedData.message, view: self)
                }
               }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
}
