//
//  AgendarOrigenDestinoCotroller.swift
//  Trok
//
//  Created by Administrator on 27/9/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

//
//  ViewController.swift
//  Trok
//
//  Created by Administrator on 11/9/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import UIKit
import MapKit

class AgendarOrigenDestinoController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var MapViewOrigen: MKMapView!
    @IBOutlet weak var MapViewDestino: MKMapView!
    
    var Origen:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem?.title = "Atrás";
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SerchButton(_ sender: UIButton) {
        Origen = true
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    
    @IBAction func SerchButton2(_ sender: UIButton) {
        Origen = false
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        if Origen == true {
        
            activeSearch.start{(response, error) in
                
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if response == nil{
                    print("Error")
                }else{
                    let annotations = self.MapViewOrigen.annotations
                    self.MapViewOrigen.removeAnnotations(annotations)
                    
                    let latitud = response?.boundingRegion.center.latitude
                    let longitud = response?.boundingRegion.center.longitude
                    
                    StructData.SourceLatitud = latitud
                    StructData.SourceLongitud = latitud
                    
                    let annotation = MKPointAnnotation()
                    annotation.title = searchBar.text
                    annotation.coordinate = CLLocationCoordinate2DMake(latitud!, longitud!)
                    
                    self.MapViewOrigen.addAnnotation(annotation)
                    
                    let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitud!, longitud!)
                    let span = MKCoordinateSpanMake(0.002, 0.002)
                    let region = MKCoordinateRegionMake(coordinate, span)
                    
                    self.MapViewOrigen.setRegion(region, animated: true)
                    
                }
            }
        }else {
        
            activeSearch.start{(response, error) in
                
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if response == nil{
                    print("Error")
                }else{
                    let annotations = self.MapViewDestino.annotations
                    self.MapViewDestino.removeAnnotations(annotations)
                    
                    let latitud = response?.boundingRegion.center.latitude
                    let longitud = response?.boundingRegion.center.longitude
                    
                    StructData.DestLatitud = latitud
                    StructData.DestLongitud = latitud
                    
                    let annotation = MKPointAnnotation()
                    annotation.title = searchBar.text
                    annotation.coordinate = CLLocationCoordinate2DMake(latitud!, longitud!)
                    
                    self.MapViewDestino.addAnnotation(annotation)
                    
                    let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitud!, longitud!)
                    let span = MKCoordinateSpanMake(0.002, 0.002)
                    let region = MKCoordinateRegionMake(coordinate, span)
                    
                    self.MapViewDestino.setRegion(region, animated: true)
                    
                }
            }
        }
        
        
    }
    @IBAction func btnVerResumenInside(_ sender: UIButton) {
        
        
        var myAlert = UIAlertController( title:"Falta Información", message: "Debe Seleccionar un Vehículo", preferredStyle: UIAlertControllerStyle.alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in
            print("ok")
        }
        
        
        
        
        
        if (StructData.SourceLatitud == nil || StructData.SourceLongitud == nil){
            
            myAlert = UIAlertController( title:"Falta Información", message: "Debe seleccionar un origen", preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            
            
            
        }
        
        if (StructData.DestLatitud == nil || StructData.DestLongitud == nil){
            
            myAlert = UIAlertController( title:"Falta Información", message: "Debe seleccionar un destino", preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            
            
            
        }
        
    }
    
}
