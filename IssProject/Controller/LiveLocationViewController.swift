//
//  LiveLocationViewController.swift
//  IssProject
//
//  Created by hicham on 10/6/18.
//  Copyright © 2018 hicham. All rights reserved.
//

import UIKit
import MapKit

class LiveLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var notifier = SpaceshipNotifier()
    var isFirstDisplay = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notifier.delegate = self
        notifier.syncSpaceship()
    }
    
}

//MARK:- Spaceship Notifaier Delegate
extension LiveLocationViewController : SpaceshipNotifaierDelegate{
    func spaceshipNewPosition(spaceship: Spaceship) {
        let coordinate = CLLocationCoordinate2D(latitude: spaceship.position.latitude, longitude: spaceship.position.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "ISS"
        // remove the last annotations
        self.mapView.removeAnnotations(self.mapView.annotations)
        // add the new annotations
        self.mapView.addAnnotation(annotation)
        if isFirstDisplay {
            self.mapView.centerCoordinate = coordinate
            isFirstDisplay = false
        }
        
    }
    
    func spaceshipSyncWithError(error: Error) {
        print("iss sync error")
    }
}
