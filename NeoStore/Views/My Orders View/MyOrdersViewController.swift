//
//  MyOrdersViewController.swift
//  NeoStore
//
//  Created by Neosoft on 21/12/21.
//

import UIKit

class MyOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK:- Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrdersApiProcessing.orderResponseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrdersCell")as! MyOrdersCell
        myOrdersApiProcessing.jsonParse(url: "http://staging.php-dev.in:8844/trainingapp/api/orderList") {
            cell.myOrdersOrderIdLbl.text = "Order ID : \(self.myOrdersApiProcessing.orderResponseData[indexPath.row].id)"
            cell.myOrdersDateLbl.text = "Ordererd Date : \(self.myOrdersApiProcessing.orderResponseData[indexPath.row].created)"
            cell.myOrdersCostLbl.text = "₹\(self.myOrdersApiProcessing.orderResponseData[indexPath.row].cost)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "OrderIdViewController")as! OrderIdViewController
        vc.order_id = self.myOrdersApiProcessing.orderResponseData[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
    
//MARK:- Variable Declarations
    @IBOutlet weak var myOrdersTableView: UITableView!
    
    var myOrdersApiProcessing = APIProcessingMyOrdersDetails()
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        myOrdersTableView.delegate = self
        myOrdersTableView.dataSource = self
        
        title = "My Orders"
        
        let myOrdersRightBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        myOrdersRightBtn.tintColor = .white
        self.navigationItem.rightBarButtonItem = myOrdersRightBtn
        
        myOrdersApiProcessing.jsonParse(url: "http://staging.php-dev.in:8844/trainingapp/api/orderList") {
            self.myOrdersTableView.reloadData()
        }
    }
}
