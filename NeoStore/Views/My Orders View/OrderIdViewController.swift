//
//  OrderIdViewController.swift
//  NeoStore
//
//  Created by Neosoft on 21/12/21.
//

import UIKit

class OrderIdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK:- TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetailApi.orderDetailsFull.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderIdCell")as! OrderIdCell
        var url_components = URLComponents(string: "http://staging.php-dev.in:8844/trainingapp/api/orderDetail")
        url_components?.queryItems = [
        URLQueryItem(name: "order_id", value:"\(order_id)")]
        orderDetailApi.jsonParse(url: (url_components?.url)!) {[self] in
            cell.OrderIdProductName.text = "\(orderDetailApi.orderDetailsFull[indexPath.row].prod_name) "
            cell.OrderIdProductCategory.text = "(\(orderDetailApi.orderDetailsFull[indexPath.row].prod_cat_name))"
            cell.OrderIdProductQuantity.text = "Quantity: \(orderDetailApi.orderDetailsFull[indexPath.row].quantity)"
            cell.OrderIdPrice.text = "₹\(orderDetailApi.orderDetailsFull[indexPath.row].total)"
            cell.OrderIdProdImage.downloaded(from: orderDetailApi.orderDetailsFull[indexPath.row].prod_image)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderIdFooterCell")as! OrderIdFooterCell
        var url_components = URLComponents(string: "http://staging.php-dev.in:8844/trainingapp/api/orderDetail")
        url_components?.queryItems = [
        URLQueryItem(name: "order_id", value:"\(order_id)")]
        orderDetailApi.jsonParse(url: (url_components?.url)!) {[self] in
            cell.orderIdTotalCost.text = "₹\(orderDetailApi.orderDetails[0].cost)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
//MARK:- Variable Declarations
    @IBOutlet weak var orderIdTableView: UITableView!
    let orderDetailApi = APIProcessingOrderDetails()
    let url = "http://staging.php-dev.in:8844/trainingapp/api/orderDetail"
    var order_id = 0
//MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        orderIdTableView.delegate = self
        orderIdTableView.dataSource = self
        orderIdTableView.register(UINib(nibName: "OrderIdFooterCell", bundle: nil), forCellReuseIdentifier: "OrderIdFooterCell")
        
        var url_components = URLComponents(string: "http://staging.php-dev.in:8844/trainingapp/api/orderDetail")
        url_components?.queryItems = [
        URLQueryItem(name: "order_id", value:"\(order_id)")]
        orderDetailApi.jsonParse(url: (url_components?.url)!) {
            self.orderIdTableView.reloadData()
            
        }
    }
}
