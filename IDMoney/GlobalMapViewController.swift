//
//  GlobalMapViewController.swift
//  IDMoney
//
//  Created by Luis Gutierrez on 10/18/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase

struct locationStruct {
    var latitude: String?
    var longitude: String?
    var uuid: String!
}

class GlobalMapViewController: UIViewController {

    var myCoordinateLat = String()
    var myCoordinateLon = String()
    
    var locations: [locationStruct] = []
    
    @IBOutlet weak var map: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        appDelegate.locationManager.startUpdatingLocation()
        appDelegate.locationManager.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUp()
        appDelegate.locationManager.stopUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - Methods
    fileprivate func setUp() {
        AddLocation()
        self.LoadLocations()
        self.LoadMap()
        
        let latitude = appDelegate.locationManager.location?.coordinate.latitude
        let longitude = appDelegate.locationManager.location?.coordinate.longitude
        self.centerCamera(inTarget: CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!))
    }
    
    func AddLocation() {
        //Creation of a unique key
//        let key = appDelegate.refClientsLocation.childByAutoId().key
        let locationData = [ //"id": key as Any,
                             "latitude": appDelegate.locationManager.location?.coordinate.latitude as Any, "longitude": appDelegate.locationManager.location?.coordinate.longitude as Any,
                             "udid" :  UIDevice.current.identifierForVendor!.uuidString as String
        ]
        appDelegate.refClientsLocation.child(UIDevice.current.identifierForVendor!.uuidString).setValue(locationData)
    }
    
    func LoadLocations(){
        let FBLocation = appDelegate.refClientsLocation
        FBLocation!.observe(DataEventType.value, with: { (snapshot) in
            let locs = snapshot.value as? NSDictionary
            if (locs?.count)! > 0 {
                for (key, value) in locs! {
                    var location = locationStruct()
                    let internalDict = locs?.value(forKey: key as! String) as! NSDictionary
                    for (k , v) in internalDict {
                        if k as! String == "latitude" {
                            location.latitude = String(format: "%@", v as! CVarArg)
                        }
                        if k as! String == "longitude" {
                            location.longitude = String(format: "%@", v as! CVarArg)
                        }
                        if k as! String == "udid" {
                            location.uuid = String(format: "%@", v as! CVarArg)
                        }
                    }
                    self.locations.append(location)
                }
                for location in self.locations {
                    if location.latitude != nil  || location.latitude == "" || location.longitude != nil  || location.longitude != "" {
                        self.showInMap(person: location)
                    }
                    
                }
            }
        })
    }
    
    fileprivate func showInMap(person: locationStruct) {
        if person.uuid !=  UIDevice.current.identifierForVendor!.uuidString as String {
            var lat: Double?
            var lng: Double?
            if let latitude = Double(person.latitude as! String) {
                print("The user entered a value price of \(person.latitude)")
                lat = Double()
                lat = latitude
            } else {
                print("Not a valid number")
            }
            if let longitude = Double(person.longitude as! String) {
                print("The user entered a value price of \(person.longitude)")
                lng = Double()
                lng = longitude
            } else {
                print("Not a valid number")
            }
            let marker = PersonLocation(uuid: person.uuid, position: CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: lng ?? 0.0)  )
            
            marker.map = self.map
        }
        
    }
    
    fileprivate func LoadMap() {
        
    }
    
    fileprivate func centerCamera(inTarget target: CLLocationCoordinate2D, animate: Bool = true, completion: (() -> Void)? = nil) {
        let camera = GMSCameraPosition.camera(withTarget: target, zoom: map.camera.zoom)
        if animate {
            map.animate(to: camera)
        } else {
            map.camera = camera
        }
        map.settings.myLocationButton = true
        map.isMyLocationEnabled = true
        guard completion != nil else { return }
        completion!()
    }
    
    // MARK - Events
    @IBAction func btnSettings(_ sender: Any) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK:- GMSMapViewDelegate
extension GlobalMapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        showInfo(fromMarker: marker)
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        hideInfo()
    }
}

//MARK: - CLLocationManagerDelegate
extension GlobalMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
