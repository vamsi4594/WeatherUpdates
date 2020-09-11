//
//  MapViewController.swift
//  WeatherUpdates
//
//  Created by 123 on 10/09/20.
//  Copyright © 2020 vamsiOSDev. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var selectedLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        mapView.addGestureRecognizer(longTapGesture)
        
    }
    @objc func longTap(sender: UIGestureRecognizer)
    {
        if sender.state == .began {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            selectedLocation = locationOnMap
            print(selectedLocation)
            performSegue(withIdentifier: "showWeatherSegue", sender: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destiVC = segue.destination as! ViewController
        destiVC.mapLatitude = selectedLocation.latitude
        destiVC.mapLongitude = selectedLocation.longitude
        
    }
  
}
