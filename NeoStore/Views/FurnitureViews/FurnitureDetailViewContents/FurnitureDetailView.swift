//
//  FurnitureDetailView.swift
//  NeoStore
//
//  Created by Neosoft on 16/12/21.
//

import UIKit

class FurnitureDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var uifuncs = UIFuncs()
    
    @IBOutlet weak var furDetailNameLbl: UILabel!
    @IBOutlet weak var furDetailCatLbl: UILabel!
    @IBOutlet weak var furDetailProducerLbl: UILabel!
    @IBOutlet weak var furDetailRatingImgView: UIImageView!
    @IBOutlet weak var furDetailCostLbl: UILabel!
    @IBOutlet weak var furDetailDescTextView: UITextView!
    @IBOutlet weak var furDetailViewBuyBtn: UIButton!
    @IBOutlet weak var furDetailViewRateBtn: UIButton!
    
    
    var prodId: Int = 0
    var prodDetailUrl:String = ""
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return furDetailImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FurnitureDetailViewCell", for: indexPath)as! FurnitureDetailViewCell
        cell.FurnitureDetailCellImgView.downloaded(from: furDetailImage[indexPath.row].image)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let colWidth = collectionView.frame.width
        return CGSize(width: colWidth/3-5, height: colWidth/3-5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let selectedImg = detailColView.cellForItem(at: indexPath)as! FurnitureDetailViewCell
        selectedImg.layer.borderColor = UIColor.red.cgColor
        selectedImg.layer.borderWidth = 1
        selectedImg.isSelected = true
        furnitureDetailImgView.image = selectedImg.FurnitureDetailCellImgView.image
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let selectedImg = detailColView.cellForItem(at: indexPath)as! FurnitureDetailViewCell
        selectedImg.layer.borderColor = UIColor.clear.cgColor
        selectedImg.isSelected = false
    }
    
    
    @IBOutlet weak var FurnitureFooterView: UIView!
    @IBOutlet weak var FurnitureContentView: UIView!
    @IBOutlet weak var detailColView: UICollectionView!
    @IBOutlet weak var furnitureDetailImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FurnitureFooterView.layer.cornerRadius = 5
        FurnitureContentView.layer.cornerRadius = 5
        
        uifuncs.btnCornerRadius(UIButton: furDetailViewBuyBtn)
        uifuncs.btnCornerRadius(UIButton: furDetailViewRateBtn)

        detailColView.delegate = self
        detailColView.dataSource = self
        
        furDetailDescTextView.isEditable = false
        
        prodDetailUrl = "http://staging.php-dev.in:8844/trainingapp/api/products/getDetail?product_id=\(prodId)"
        
        jsonParse(url: prodDetailUrl) { [self] in
            
            self.title = furDetailData[0].name
            self.detailColView.reloadData()
            self.furDetailCostLbl.text = "Rs. \(furDetailData[0].cost)"
            self.furDetailDescTextView.text = furDetailData[0].description
            
            self.furDetailNameLbl.text = self.furDetailData[0].name
            
            if self.furDetailData[0].product_category_id == 1{
                self.furDetailCatLbl.text = "Category - Table"
            }
            else if self.furDetailData[0].product_category_id == 2{
                self.furDetailCatLbl.text = "Category - Chair"
            }
            else if self.furDetailData[0].product_category_id == 3{
                self.furDetailCatLbl.text = "Category - Sofa"
            }
            else if self.furDetailData[0].product_category_id == 4{
                self.furDetailCatLbl.text = "Category - Bed"
            }
            
            self.furDetailProducerLbl.text = self.furDetailData[0].producer
            
            if self.furDetailData[0].rating == 1{
                self.furDetailRatingImgView.image = UIImage(named: "star_one")
            }
            else if self.furDetailData[0].rating == 2{
                self.furDetailRatingImgView.image = UIImage(named: "star_two")
            }
            else if self.furDetailData[0].rating == 3{
                self.furDetailRatingImgView.image = UIImage(named: "star_three")
            }
            else if self.furDetailData[0].rating == 4{
                self.furDetailRatingImgView.image = UIImage(named: "star_four")
            }
            else if self.furDetailData[0].rating == 5{
                self.furDetailRatingImgView.image = UIImage(named: "star_five")
            }
            print("hello\(self.furDetailData)")
            furnitureDetailImgView.downloaded(from: furDetailImage[0].image)
        }
    }
    
    @IBAction func furDetailViewBuyBtnClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "FurnitureBuyViewController")as! FurnitureBuyViewController
        vc.buyProdId = self.prodId
        vc.buyNameLbl = furDetailData[0].name
        vc.buyImageLink = furDetailImage[0].image
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func furDetailRateBtnClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "RateViewController")as! RateViewController
        vc.rateProdId = self.prodId
        vc.rateNameLbl = furDetailData[0].name
        vc.rateImageLink = furDetailImage[0].image
        present(vc, animated: true, completion: nil)
    }
    
    var furDetailData = [FurDetailData]()
    var furDetailImage = [FurDetailImages]()
    
    func jsonParse(url:String,completed: @escaping () -> ()){
        guard let url = URL(string: url)else{return}
        let session = URLSession.shared
        session.dataTask(with: url){(data,response,error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do{
                    let pdata = try
                        JSONDecoder().decode(FurDetailDataData.self, from:data)
                    self.furDetailData = [pdata.data]
                    self.furDetailImage = pdata.data.product_images
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print(error)
                }
            }
        }.resume()
    }
}

