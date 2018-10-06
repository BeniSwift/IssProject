//
//  IssPassViewController.swift
//  IssProject
//
//  Created by hicham on 10/6/18.
//  Copyright © 2018 hicham. All rights reserved.
//

import UIKit
import CoreLocation


class IssPassViewController : UITableViewController,CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager!
    var passes : [(duration:Int,risetime:TimeInterval)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUserLocation()
    }
    
    func initUserLocation() {
        locationManager = CLLocationManager()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation : CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let spaceshipManager = SpaceshipManager()
        spaceshipManager.getSpaceshipPassesFor(position: (lat: userLocation.latitude, long: userLocation.longitude), complition: { (passes) in
            self.passes = passes
            self.tableView.reloadData()
            self.locationManager.stopUpdatingLocation()
        }) { (error) in
            print(error)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "")
        let pass = passes[indexPath.item]
        cell.textLabel?.text = pass.risetime.toStringDate()
        cell.detailTextLabel?.text = pass.duration.secondsToFullTime()
        return cell
    }
    
}
