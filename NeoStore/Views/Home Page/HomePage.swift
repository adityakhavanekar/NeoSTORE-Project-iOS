//
//  HomePage.swift
//  NeoStore
//
//  Created by Neosoft on 09/12/21.
//

import UIKit
import SideMenu

class HomePage: UIViewController {
    
    //MARK:- OutLets
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var sliderPageControll: UIPageControl!
    @IBOutlet weak var elementsCollectionView: UICollectionView!
    
    //MARK:- Variables
    //UIFunc Class Instance
    var uifuncs = UIFuncs()
    var urls = Api_strings()
    //Slider Data class
    var sliderData = SliderData()
    //Element Data
    var elements = HomeElements()
    //Timer Variable
    var slideTimer = Timer()
    var sliderCounter = 0

    //MARK:- View Did Load Function
    override func viewDidLoad() {
        super.viewDidLoad()
        //Slider Menu
        uifuncs.SideMenu(view: self.view)
        
        // page controll for sliderImages
        sliderPageControll.numberOfPages = sliderData.sliderImages.count
        sliderPageControll.currentPage = 0
        DispatchQueue.main.async { [self] in
            slideTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(changeImage), userInfo: nil, repeats: true)
        }
    }
    @objc func changeImage(){
        if sliderCounter < sliderData.sliderImages.count{
            let index = IndexPath.init(item: sliderCounter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            sliderPageControll.currentPage = sliderCounter
            sliderCounter += 1
        }else{
            sliderCounter = 0
            let index = IndexPath.init(item: sliderCounter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            sliderPageControll.currentPage = sliderCounter
        }
    }
    
    //MARK:- IB Actions
    // SideMenu Clicked
    @IBAction func menuTapped(_ sender: UIBarButtonItem) {
        present(uifuncs.menu!, animated: true, completion: nil)
    }
}
//MARK:- Extension For CollectionView

extension HomePage: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sliderCollectionView{
            return sliderData.sliderImages.count
        }
        return elements.elements.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sliderCollectionView{
            let sCell = sliderCollectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath)as! ImageSliderCell
            sCell.sliderImgView.image = sliderData.sliderImages[indexPath.row]
            return sCell
        }
        let eCell = elementsCollectionView.dequeueReusableCell(withReuseIdentifier: "eCell", for: indexPath)as! ElementCell
        eCell.eCellImgView.image = elements.elements[indexPath.row]
        return eCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == elementsCollectionView{
            let cell = elementsCollectionView.cellForItem(at: indexPath)as! ElementCell
            let cellImg:UIImage = cell.eCellImgView.image!
            print(cellImg)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if cellImg == UIImage(named: "sofaicon"){
                let sv = sb.instantiateViewController(identifier: "FurnitureViewController")as! FurnitureViewController
                sv.url = urls.urls[2]
                navigationController?.pushViewController(sv, animated: true)
            }
            else if cellImg == UIImage(named: "chairsicon"){
                let sv = sb.instantiateViewController(identifier: "FurnitureViewController")as! FurnitureViewController
                sv.url = urls.urls[1]
                navigationController?.pushViewController(sv, animated: true)
            }
            else if cellImg == UIImage(named: "cupboardicon"){
                let sv = sb.instantiateViewController(identifier: "FurnitureViewController")as! FurnitureViewController
                sv.url = urls.urls[3]
                navigationController?.pushViewController(sv, animated: true)
            }
            else if cellImg == UIImage(named: "tableicon"){
                let sv = sb.instantiateViewController(identifier: "FurnitureViewController")as! FurnitureViewController
                sv.url = urls.urls[0]
                navigationController?.pushViewController(sv, animated: true)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sliderCollectionView{
            let collectionViewHeight = sliderCollectionView.frame.height
            let collectionViewWidth = sliderCollectionView.frame.width
            return CGSize(width: collectionViewWidth, height: collectionViewHeight)
        }
        let eCollectionViewWidth = elementsCollectionView.frame.width
        return CGSize(width: eCollectionViewWidth/2 - 11.66, height: eCollectionViewWidth/2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == sliderCollectionView{
            return 0
        }
        return 11.66
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == sliderCollectionView{
            return 0
        }
        return 0
    }
}
