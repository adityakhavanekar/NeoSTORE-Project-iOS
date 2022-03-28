//
//  SideViewController.swift
//  NeoStore
//
//  Created by Neosoft on 09/12/21.
//

import UIKit

class SideViewController: UITableViewController {

    //MARK:- Variables Declarations
    var sideData = SideMenuData()
    var urls = Api_strings()
    var views = Views()
    var apiUserData = APIProcessingUserDetails()
    var apiMyCartDetails = APIProcessingMyCartDetails()
    //MARK:- View Did Load and View Did Appear
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "sideMenuTableViewCell", bundle: nil), forCellReuseIdentifier:"cell")
        tableView.register(UINib(nibName: "SideMenuHeaderCell", bundle: nil), forCellReuseIdentifier:"hCell")
        tableView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        apiMyCartDetails.jsonParse(url: "http://staging.php-dev.in:8844/trainingapp/api/cart") {
            self.tableView.reloadData()
            }
    }
    override func viewDidAppear(_ animated: Bool) {
        apiMyCartDetails.jsonParse(url: "http://staging.php-dev.in:8844/trainingapp/api/cart") {
            self.tableView.reloadData()
        }
        self.tableView.reloadData()
    }
    /*override func viewWillAppear(_ animated: Bool) {
        apiMyCartDetails.jsonParse(url: "http://staging.php-dev.in:8844/trainingapp/api/cart") {
            self.tableView.reloadData()
        }
    }*/

    // MARK: - Table view Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideData.data.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! sideMenuTableViewCell
        cell.sideMenuCellLbl.text = sideData.data[indexPath.row]
        cell.firstImageViewCell.image = UIImage(named: sideData.firstImages[indexPath.row])
        if cell.sideMenuCellLbl.text == "My Cart"{
            cell.cartCount.backgroundColor = .red
            apiMyCartDetails.jsonParse(url: "http://staging.php-dev.in:8844/trainingapp/api/cart") {
                
                    
                
                    cell.cartCountNumberLbl.text = "\(self.apiMyCartDetails.cartResponseData.count)"
                
                
            }
            //
            cell.cartCountNumberLbl.textColor = .white
            //print(apiMyCartDetails.cartResponseData.count)
            
            }
        return cell
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hCell = tableView.dequeueReusableCell(withIdentifier: "hCell")as! SideMenuHeaderCell
        apiUserData.jsonParse(url: "http://staging.php-dev.in:8844/trainingapp/api/users/getUserData") { [self] in
            hCell.sideHeaderNameLbl.text = "\(apiUserData.userListData[0].first_name)"
            hCell.sideHeaderEmailLbl.text = "\(apiUserData.userListData[0].email)"
            if apiUserData.userListData[0].profile_pic != nil{
                hCell.sideHeaderImgView.downloaded(from: apiUserData.userListData[0].profile_pic!)
            }
            
            print(apiUserData.userListData)
        }
        return hCell
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)as! sideMenuTableViewCell
        let cellInfo = (cell.sideMenuCellLbl?.text!)!
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if cellInfo == "Chair"{
            let vc = sb.instantiateViewController(identifier: "FurnitureViewController")as! FurnitureViewController
            vc.url = urls.urls[1]
            vc.title = cellInfo
            navigationController?.pushViewController(vc, animated: true)
        }
        else if cellInfo == "Table"{
            let vc = sb.instantiateViewController(identifier: "FurnitureViewController")as! FurnitureViewController
            vc.url = urls.urls[0]
            vc.title = cellInfo
            navigationController?.pushViewController(vc, animated: true)
        }
        else if cellInfo == "Sofas"{
            let vc = sb.instantiateViewController(identifier: "FurnitureViewController")as! FurnitureViewController
            vc.url = urls.urls[2]
            vc.title = cellInfo
            navigationController?.pushViewController(vc, animated: true)
        }
        else if cellInfo == "Cupboard"{
            let vc = sb.instantiateViewController(identifier: "FurnitureViewController")as! FurnitureViewController
            vc.url = urls.urls[3]
            vc.title = cellInfo
            navigationController?.pushViewController(vc, animated: true)
        }
        else if cellInfo == "My Account"{
            let vc = sb.instantiateViewController(identifier: "MyAccountViewController")as! MyAccountViewController
            vc.title = cellInfo
            navigationController?.pushViewController(vc, animated: true)
        }
        else if cellInfo == "My Cart"{
            let vc = sb.instantiateViewController(identifier: "MyCartViewController")as! MyCartViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        else if cellInfo == "Store Locator"{
            let vc = sb.instantiateViewController(identifier: "StoreLocatorViewController")as! StoreLocatorViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        else if cellInfo == "My Orders"{
            let vc = sb.instantiateViewController(identifier: "MyOrdersViewController")as! MyOrdersViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        else if cellInfo == "Logout"{
            AddressLists.removeAll()
            self.dismiss(animated: true, completion: nil)
            let vc = sb.instantiateViewController(identifier: "LoginPage")as! ViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
