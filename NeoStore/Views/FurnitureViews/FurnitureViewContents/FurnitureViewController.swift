//
//  FurnitureViewController.swift
//  NeoStore
//
//  Created by Neosoft on 15/12/21.
//

import UIKit

class FurnitureViewController: UITableViewController {
    
    var api = APIProcessing()
    var url = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FurnitureCell", bundle: nil), forCellReuseIdentifier: "furCell")
        api.jsonParse(url: url) {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return api.furListData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "furCell", for: indexPath)as! FurnitureCell
        cell.furNameLbl.text = api.furListData[indexPath.row].name
        cell.furCostLbl.text = "Rs.\(api.furListData[indexPath.row].cost)"
        cell.furDescLbl.text = api.furListData[indexPath.row].producer
        cell.furImgView.downloaded(from: api.furListData[indexPath.row].product_images)
        
        if self.api.furListData[indexPath.row].rating == 1{
            cell.furRatingImageView.image = UIImage(named: "star_one")
        }else if self.api.furListData[indexPath.row].rating == 2{
            cell.furRatingImageView.image = UIImage(named:"star_two")
        }else if api.furListData[indexPath.row].rating == 3{
            cell.furRatingImageView.image = UIImage(named: "star_three")
        }else if api.furListData[indexPath.row].rating == 4{
            cell.furRatingImageView.image = UIImage(named: "star_four")
        }else if api.furListData[indexPath.row].rating == 5{
            cell.furRatingImageView.image = UIImage(named: "star_five")
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let id = api.furListData[indexPath.row].id
        let vc = sb.instantiateViewController(identifier: "FurnitureDetailView")as! FurnitureDetailViewController
        vc.prodId = id
        navigationController?.pushViewController(vc, animated: true)
    }
}
