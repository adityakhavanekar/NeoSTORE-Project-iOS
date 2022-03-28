//
//  AddressListViewController.swift
//  NeoStore
//
//  Created by Neosoft on 20/12/21.
//

import UIKit

class AddressListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddressLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell")as! AddressCell
        apiGetUserDetails.jsonParse(url: "http://staging.php-dev.in:8844/trainingapp/api/users/getUserData") {
            cell.addressNameLbl.text = "\( self.apiGetUserDetails.userListData[0].first_name) \(self.apiGetUserDetails.userListData[0].last_name)"
            }
        cell.addressTextView.text = "\(AddressLists[indexPath.row].AddressText)"
        cell.addressListSelectBtn.backgroundColor = .lightGray
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)as! AddressCell
        
        cell.addressListSelectBtn.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)as! AddressCell
        cell.addressListSelectBtn.backgroundColor = .gray
    }
    
    var uifuncs = UIFuncs()
    var apiGetUserDetails = APIProcessingUserDetails()

    
    var address1 = ["mumbai","delhi","pune"]
    var address2 = ["mulund","vasant kunj","Hinjewadi"]
    let url = URL(string: "http://staging.php-dev.in:8844/trainingapp/api/order")
    let userAcessToken = UserDefaults.standard.string(forKey: "userAcessToken")as Any
    @IBOutlet weak var addressListPlaceOrderBtn: UIButton!
    @IBOutlet weak var addressListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "Address List"
        let addAddressBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAddressView))
        self.navigationItem.rightBarButtonItem = addAddressBtn
        uifuncs.btnCornerRadius(UIButton: addressListPlaceOrderBtn)
        
        addressListTableView.delegate = self
        addressListTableView.dataSource = self
        
        apiGetUserDetails.jsonParse(url: "http://staging.php-dev.in:8844/trainingapp/api/users/getUserData") {
            print("success")
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addressListTableView.reloadData()
    }
    
    
    @objc func addAddressView(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AddAddressViewController")as! AddAddressViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deleteAddressClicked(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: addressListTableView)
        guard let indexPath = addressListTableView.indexPathForRow(at: point)else{return}
        AddressLists.remove(at: indexPath.row)
        addressListTableView.beginUpdates()
        addressListTableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .left)
        addressListTableView.endUpdates()
    }
    
    @IBAction func placeOrderClicked(_ sender: UIButton) {
        if AddressLists.isEmpty{
            uifuncs.showAlert(message: "Add Address", title: "Add Address", view: self)
        }
        else{
            let cell = addressListTableView.indexPathForSelectedRow
            if cell == nil{
                uifuncs.showAlert(message: "Select Address", title: "Select Address", view: self)
            }
            else{
                let currentCell = addressListTableView.cellForRow(at:cell!)as! AddressCell
                print(currentCell.addressTextView.text!)
                let body:[String:Any] = [
                    "address" : "\(currentCell.addressTextView.text!)"
                ]
                ApiServicePlaceOrder.callPost(url: url!, access_token: userAcessToken as! String, params: body, finish: finishOrderPost)
                
            }
            
        }
        
        
    }
    func finishOrderPost (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
            {
                let parsedData = try JSONDecoder().decode(OrderPlaced.self, from: jsonData)
                print(parsedData.status)
                print(parsedData.message)
                print(parsedData.user_msg)
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


