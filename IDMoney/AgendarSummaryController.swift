//
//  AgendarSummaryController.swift
//  Trok
//
//  Created by Administrator on 27/9/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import UIKit
import MapKit

class AgendarSummaryController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var imgOrigen: UIImageView!
    @IBOutlet weak var imgDestino: UIImageView!

    @IBOutlet weak var Foto: UIImageView!
    @IBOutlet weak var SummaryMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Foto.layer.cornerRadius = Foto.frame.size.width/2
        Foto.clipsToBounds = true
        
        let newImg: UIImage? = UIImage(named: "Casa.ico")
        let newImg2: UIImage? = UIImage(named: "Casa2.PNG")
        let newImg3: UIImage? = UIImage(named: "Edificios.PNG")
        let newImg4: UIImage? = UIImage(named: "Bodega.PNG")
        
        
        if StructData.OrigenHouse == 1 {
            self.imgOrigen.image  = newImg
        }
        if StructData.OrigenHouse == 2 {
            self.imgOrigen.image  = newImg2
            
        }
        if StructData.OrigenHouse == 3 {
            self.imgOrigen.image  = newImg3
            
        }
        if StructData.OrigenHouse == 4 {
            self.imgOrigen.image  = newImg4
            
        }
        
        
        if StructData.DestinoHouse == 1 {
            self.imgDestino.image  = newImg
        }
        if StructData.DestinoHouse == 2 {
            self.imgDestino.image  = newImg2
        }
        if StructData.DestinoHouse == 3 {
            self.imgDestino.image  = newImg3
        }
        if StructData.DestinoHouse == 4 {
            self.imgDestino.image  = newImg4
        }

        
        
        let vnewImg: UIImage? = UIImage(named: "CL0.PNG")
        let vnewImg2: UIImage? = UIImage(named: "minivan.PNG")
        let vnewImg3: UIImage? = UIImage(named: "CL2.PNG")
        let vnewImg4: UIImage? = UIImage(named: "CL3.PNG")
        let vnewImg5: UIImage? = UIImage(named: "CL Grande.PNG")
        let vnewImg6: UIImage? = UIImage(named: "Grua.PNG")
        let vnewImg7: UIImage? = UIImage(named: "Ambulancia.PNG")
        let vnewImg8: UIImage? = UIImage(named: "bajo.PNG")
        
        
        
        
        if StructData.vehiculo == 1 {
            self.Foto.image = vnewImg
        }
        if StructData.vehiculo == 2 {
            self.Foto.image = vnewImg2
        }
        if StructData.vehiculo == 3 {
            self.Foto.image = vnewImg3
        }
        if StructData.vehiculo == 4 {
            self.Foto.image = vnewImg4
        }
        if StructData.vehiculo == 5 {
            self.Foto.image = vnewImg5
        }
        if StructData.vehiculo == 6 {
            self.Foto.image = vnewImg6
        }
        if StructData.vehiculo == 7 {
            self.Foto.image = vnewImg7
        }
        if StructData.vehiculo == 8 {
            self.Foto.image = vnewImg8
        }

        

        
        SummaryMapView.delegate = self
        SummaryMapView.showsScale = true
        SummaryMapView.showsPointsOfInterest = true
        SummaryMapView.showsUserLocation = true
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
        
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        
       
        
        let sourceCoordinates = locationManager.location?.coordinate//CLLocationCoordinate2DMake(9.927483, -84.066355)
        
        let destCoordinates = CLLocationCoordinate2DMake(9.863809, -83.916193)
        
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates!)
        
        let destPlacemark = MKPlacemark(coordinate: destCoordinates)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        
        let destItem = MKMapItem(placemark: destPlacemark)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate(completionHandler: {
            (response, error) in
            guard let response = response else {
                if let error = error {
                    print("error calculando \(error.localizedDescription)")
                }
                return
            }
            
            let route = response.routes[0]
            self.SummaryMapView.add(route.polyline, level: .aboveRoads)
            
            let rekt = route.polyline.boundingMapRect
            self.SummaryMapView.setRegion(MKCoordinateRegionForMapRect(rekt), animated: true)
        
        })
        
        
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        
        return renderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnSolicitarInside(_ sender: Any) {
        
        
        
        var myAlert = UIAlertController( title:"Solicitar", message: "Desea solicitar un transporte?. Asegurese que todos los datos sean correctos", preferredStyle: UIAlertControllerStyle.alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in
            
        
        
            var myAlert2 = UIAlertController( title:"Solicitar", message: "Estamos buscando su transporte. Le estaremos informando en breve", preferredStyle: UIAlertControllerStyle.alert)
            
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in

            }
            
            
            
            
            myAlert2.addAction(okAction)
            
            
            self.present(myAlert2, animated: true, completion: nil)
        
        
        
        }
        
        let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.default){(ACTION) in
            print("ok")
        }
        
        
        myAlert.addAction(okAction)
        myAlert.addAction(cancelAction)
        
        self.present(myAlert, animated: true, completion: nil)
    }
    
    
    
    
    
}


