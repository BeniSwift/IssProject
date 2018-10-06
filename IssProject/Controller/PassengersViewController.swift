//
//  PassengersViewController.swift
//  IssProject
//
//  Created by hicham on 10/6/18.
//  Copyright © 2018 hicham. All rights reserved.
//

import UIKit

class PassengersViewController : UITableViewController {
    
    var passengers : [Passenger] = []
    var manager : PassengerManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = PassengerManager()
        manager.getPassengers(complition: { (passengers) in
            self.passengers = passengers
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passengers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let passenger = passengers[indexPath.item]
        cell.textLabel?.text = passenger.name
        return cell
    }
    
}
