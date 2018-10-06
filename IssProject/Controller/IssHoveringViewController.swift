//
//  IssHoveringViewController.swift
//  IssProject
//
//  Created by hicham on 10/6/18.
//  Copyright © 2018 hicham. All rights reserved.
//

import Foundation

import UIKit
import MapKit

class IssHoveringViewController: UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    var notifier = SpaceshipNotifier()
    var locationManager : CLLocationManager!
    var cercle: MKCircle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUserLocation()
        notifier.delegate = self
        notifier.syncSpaceship()
        mapView.delegate = self
    }
    
    func initUserLocation() {
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            mapView.showsUserLocation = true
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func isIssAboveUser(issCoordiante: CLLocationCoordinate2D) {
        let currenPoint = self.mapView.renderer(for: cercle) as? MKCircleRenderer
        let issPoint = self.mapView.convert(issCoordiante, toPointTo: self.mapView)
        
        if !currenPoint!.path.contains(issPoint) {
            
            let alert = UIAlertController(title: "alert", message: "The ISS is above the user", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension IssHoveringViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation : CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        let regionRadius = 40000 // meters
        let coordinateRegion = MKCoordinateRegion( center: userLocation, latitudinalMeters: CLLocationDistance(regionRadius), longitudinalMeters: CLLocationDistance(regionRadius) )
        self.mapView.setRegion( coordinateRegion, animated: true)
        
        cercle = MKCircle(center: userLocation, radius: 10000)
        self.mapView.addOverlay(cercle)
        
        self.locationManager.stopUpdatingLocation()
    }
    
}

extension IssHoveringViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.fillColor = UIColor.red.withAlphaComponent(0.5)
        circleRenderer.strokeColor = UIColor.yellow
        circleRenderer.lineWidth = 1
        return circleRenderer
    }
}

extension IssHoveringViewController : SpaceshipNotifaierDelegate{
    func spaceshipNewPosition(spaceship: Spaceship) {
        let coordinate = CLLocationCoordinate2D(latitude: spaceship.position.latitude, longitude: spaceship.position.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "ISS"
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotation(annotation)
        //check if the iss is above the user location
        isIssAboveUser(issCoordiante: coordinate)
    }
    
    func spaceshipSyncWithError(error: Error) {
        print("iss sync error")
    }
}
