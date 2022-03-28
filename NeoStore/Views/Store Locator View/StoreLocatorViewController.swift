//
//  StoreLocatorViewController.swift
//  NeoStore
//
//  Created by Neosoft on 21/12/21.
//

import UIKit
import MapKit

class StoreLocatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = StoreLocatorTableView.dequeueReusableCell(withIdentifier: "StoreLocatorCell")as! StoreLocatorCell
        cell.storeLocatorIconImage.image = UIImage(named: "storelocator_icon")
        cell.storeLocatorStoreName.text = locations[indexPath.row]["title"]as? String
        cell.storeLocatorStoreAddress.text = locations[indexPath.row]["address"]as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedLocation = CLLocation(latitude: locations[indexPath.row]["latitude"]as! CLLocationDegrees, longitude: locations[indexPath.row]["longitude"]as! CLLocationDegrees)
        createStoreZomm(location: tappedLocation)
    }

    
    @IBOutlet weak var StoreLocatorTableView: UITableView!
    @IBOutlet weak var StoreLocatorMapView: MKMapView!
    
    let initLocation = CLLocation(latitude: 36.668769, longitude: -100.860281)
    let initDistance: CLLocationDistance = 5000000
    let storeL1 = CLLocation(latitude: 40.713054, longitude: -74.007228)
    let storeL2 = CLLocation(latitude: 34.052238, longitude: -118.243344)
    let storeL3 = CLLocation(latitude: 41.883229, longitude: -87.632398)
    let storeDistance: CLLocationDistance = 500
    
    let locations = [
        ["title":"New York, NY", "address":"2/25, New Police Colony, WC, USA","latitude": 40.713054,"longitude":-74.007228],
        ["title":"Los Angeles, CA","address":"Store no.323, New Police Colony, WC, USA","latitude": 34.052238,"longitude":-118.243344],
        ["title":"Chicago, IL","address":"Plot no. 85,New Police Colony, WC, USA","latitude":41.883229,"longitude":-87.632398]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAnnot(locations:locations)
        createZoom(location:initLocation)
        
        StoreLocatorTableView.delegate = self
        StoreLocatorTableView.dataSource = self
        
        title = "Store Locator"
    }
    
    func createAnnot(locations:[[String:Any]]){
        for location in locations{
            let annotation = MKPointAnnotation()
            annotation.title = location["title"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"]as! CLLocationDegrees)
            StoreLocatorMapView.addAnnotation(annotation)
            
        }
    }
    
    func createZoom(location: CLLocation){
        let mapCoordinate = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: initDistance,longitudinalMeters: storeDistance)
        StoreLocatorMapView.setRegion(mapCoordinate, animated: true)
    }
    
    func createStoreZomm(location: CLLocation){
        let mapCoordinate = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: storeDistance,longitudinalMeters: storeDistance)
        StoreLocatorMapView.setRegion(mapCoordinate, animated: true)
    }
    
}
