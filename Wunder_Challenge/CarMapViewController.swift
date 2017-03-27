//
//  CarMapViewController.swift
//  Wunder_Challenge
//
//  Created by Mohamed Magdy on 3/26/17.
//  Copyright © 2017 Mohamed Magdy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class CarMapViewController: BaseViewController, CLLocationManagerDelegate {

    //MARK:- Properties
    var cars: [CarViewModel]?
    private var locationManager: CLLocationManager?
    //MARK:- Outlets
    @IBOutlet private weak var mapView: MKMapView!
    
    //MARK:- View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        setupLocation()
        addCarsAnnotations()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Private Methods
    private func setupMap() {
        mapView.showsUserLocation = true
        mapView.delegate = self
    }
    private func setupLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
    }
    
    fileprivate func addCarsAnnotations() {
        if let carsArray = cars {
            for car in carsArray {
                if let lat = car.latitude, let longi = car.longitude {
                    let annotation = MKPointAnnotation()
                    annotation.title = car.name
                    annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: longi)
                    mapView.addAnnotation(annotation)
                }
            }
        }
    }

    //MARK:- CLLocationManagerDelegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        if let userLocation = location {
            let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            mapView.setCenter(center, animated: true)
        }
        manager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
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

extension CarMapViewController: MKMapViewDelegate {
    
    //MARK:- MKMapViewDelegate Methods
    //Remove all pins except the one tabbed
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotations = mapView.annotations
        for annotation in annotations {
            if annotation.isEqual(view.annotation) {
                continue
            }
            else {
                mapView.removeAnnotation(annotation)
            }
        }
    }
    //Add all the pins back when the current pin is deselected
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        mapView.removeAnnotations(mapView.annotations)
        addCarsAnnotations()
    }
}
