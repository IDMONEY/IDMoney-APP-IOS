//
//  HomeController.swift
//  Trok
//
//  Created by Administrator on 13/9/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var Foto: UIImageView!
    @IBOutlet weak var Menu: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var MapSource: MKMapView!
    @IBOutlet weak var MapDestination: MKMapView!
    
    var menuShowing = false
    
    
     let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude)
        let region = MKCoordinateRegionMake(myLocation,span)
        
        MapSource.setRegion(region, animated: true)
        
        print(location.altitude)
        print(location.speed)
        
        self.MapSource.showsUserLocation = true
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkReachability()
        
        
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            }
        } else {
            print("Location services are not enabled")
        }
        
        
        
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "menu.png"), for: UIControlState.normal)
        button.addTarget(self, action:#selector(HomeController.callMethod), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50) //CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        
        
        // Do any additional setup after loading the view, typically from a nib.
        Menu.layer.shadowOpacity = 6
        Menu.layer.shadowRadius = 6
        
        Foto.layer.cornerRadius = Foto.frame.size.width/2
        Foto.clipsToBounds = true
        
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
//        MapSource.showsUserLocation = true
//        MapSource.delegate = self
//        
        
//        let userLocation = MapSource.userLocation
//        //let region = MKCoordinateRegionMakeWithDistance((userLocation.location?.coordinate)!, 2000, 2000)
////        MapSource.setRegion(region, animated: true)
//
////        print(userLocation.coordinate.latitude)
////        print(userLocation.coordinate.longitude)
//        
//       let location = CLLocationCoordinate2DMake(9.927483, -84.066355)
////
//        let span = MKCoordinateSpanMake(0.010, 0.010)
////        
//        let region = MKCoordinateRegionMake(location, span)
////        
//        MapSource.setRegion(region, animated: true)
////
////        let annotation = MKPointAnnotation()
////        annotation.coordinate = location
////        annotation.title = "Parque Central"
////        annotation.subtitle = "San Jose"
////        
////        MapSource.addAnnotation(annotation)
//        //sleep(10)
//        
//        
////        print(userLocation.coordinate.latitude)
////        print(userLocation.coordinate.longitude)

        
        
 
        
        
    }
    

    
    func callMethod() {
        if (menuShowing){
            leadingConstraint.constant = -200
        }else{
            leadingConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        }
        menuShowing = !menuShowing
    }
    
    @IBAction func btnLocationInside(_ sender: UIButton) {
        
        let userLocation = MapSource.userLocation
        
                print(userLocation.coordinate.latitude)
                print(userLocation.coordinate.longitude)
        let region = MKCoordinateRegionMakeWithDistance((userLocation.location?.coordinate)!, 2000, 2000)
        MapSource.setRegion(region, animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Menu(_ sender: UIBarButtonItem) {
    
        if (menuShowing){
            leadingConstraint.constant = -200
        }else{
            leadingConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        }
        menuShowing = !menuShowing
    }
    
    func checkReachability(){
        if currentReachabilityStatus == .reachableViaWiFi {
            //print("User is connected to the internet via wifi.")
        }else if currentReachabilityStatus == .reachableViaWWAN{
            //print("User is connected to the internet via WWAN.")
        } else {
            let myAlert = UIAlertController( title:"Error conexión", message: "No hay conexión a internet, por favor verifique su conexión", preferredStyle: UIAlertControllerStyle.alert)
            
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in
                print("ok")
            }
            
            
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
                
            
            //print("There is no internet connection")
        }
    }
    
}
