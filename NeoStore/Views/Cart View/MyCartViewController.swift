//
//  MyCartViewController.swift
//  NeoStore
//
//  Created by Neosoft on 20/12/21.
//

import UIKit
import iOSDropDown

class MyCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var uifuncs = UIFuncs()
    var myCartApiProcessing = APIProcessingMyCartDetails()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCartApiProcessing.cartResponseData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartCell")as! MyCartCell
        myCartApiProcessing.jsonParse(url: "http://staging.php-dev.in:8844/trainingapp/api/cart") {
                cell.myCartCellLbl.text = "\(self.myCartApiProcessing.cartResponseData[indexPath.row].product.name)"
                cell.myCartCellLbl2.text = "(\(self.myCartApiProcessing.cartResponseData[indexPath.row].product.product_category))"
                cell.myCartCellQuantityLbl.text = "\(self.myCartApiProcessing.cartResponseData[indexPath.row].quantity)"
                cell.myCartCostLbl.text = "\(self.myCartApiProcessing.cartResponseData[indexPath.row].product.sub_total)"
            cell.myCartCellImgView.downloaded(from: self.myCartApiProcessing.cartResponseData[indexPath.row].product.product_images)
                cell.prodId = self.myCartApiProcessing.cartResponseData[indexPath.row].product_id
                cell.prodQuantity = self.myCartApiProcessing.cartResponseData[indexPath.row].quantity
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: nil){(_,_,_)in
            let prodIDToDelete = self.myCartApiProcessing.cartResponseData[indexPath.row].product_id
            let urlStringDelete = URL(string: "http://staging.php-dev.in:8844/trainingapp/api/deleteCart")
            let body2:[String:Any] = [
                "product_id":"\(prodIDToDelete)"
            ]
            ApiServiceUpdateUserDetails.callPost(url: urlStringDelete!, access_token: self.userAcessToken as! String, params:body2, finish:self.finishDeleteCartItem)
        }
        deleteAction.backgroundColor = .systemBackground
        deleteAction.image = UIImage(named: "delete")
        let configration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configration
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cost = myCartApiProcessing.cartResponse
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCartFCell")as! myCartFooterCell
        cell.myCartTotalCostLbl.text = "₹\(String(describing: cost))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121
    }
    
    
    
    
    func finishDeleteCartItem(message:String, data:Data?)->Void{
        do{
            if let jsonData = data{
                myCartApiProcessing.jsonParse(url: "http://staging.php-dev.in:8844/trainingapp/api/cart") {
                    self.myCartTableView.reloadData()
                }
            }
        }
    }
    
    
    @IBOutlet weak var myCartTableView: UITableView!
    @IBOutlet weak var myCartOrderNowBtn: UIButton!
    let userAcessToken = UserDefaults.standard.string(forKey: "userAcessToken")as Any
    var cart = ["1","2","3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uifuncs.btnCornerRadius(UIButton: myCartOrderNowBtn)
        
        myCartTableView.delegate = self
        myCartTableView.dataSource = self
        
        myCartTableView.register(UINib(nibName: "myCartFooterCell", bundle: nil), forCellReuseIdentifier: "myCartFCell")
        
        myCartApiProcessing.jsonParse(url: "http://staging.php-dev.in:8844/trainingapp/api/cart") {
            self.myCartTableView.reloadData()
            
        }
        NotificationCenter.default.addObserver(self, selector: #selector(reloadMyCartTableData), name: Notification.Name("CartEdited"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.myCartTableView.reloadData()
    }
    
    @objc func reloadMyCartTableData(){
        myCartApiProcessing.jsonParse(url: "http://staging.php-dev.in:8844/trainingapp/api/cart") {
            self.myCartTableView.reloadData()
        }
    }
    
    
    @IBAction func myCartOrderNowClicked(_ sender: UIButton) {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(identifier: "AddressListViewController")as! AddressListViewController
                self.navigationController?.pushViewController(vc, animated: true)
           }
}
