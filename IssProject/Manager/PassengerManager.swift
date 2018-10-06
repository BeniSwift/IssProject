//
//  PassengerManager.swift
//  IssProject
//
//  Created by hicham on 10/6/18.
//  Copyright © 2018 hicham. All rights reserved.
//

import Foundation

struct PassengerManager {
    
    func getPassengers(complition:((_ passengers:[Passenger]) -> Void)?,withError:((_ error:Error) -> Void)?){
        var passengers : [Passenger] = []
        HTTPRequestMaker.doRequest(_to: ISS_PASSENGERS_URL, _using: HTTPRequestMethods.Get.rawValue, _with: [:], completion: { (data) in
            guard data != nil else {
                print("error at geting passes data")
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let dictionary = json as? [String: Any] {
                if let peoples = dictionary["people"] as? [[String: Any]] {
                    for people in peoples {
                        guard let name = people["name"] as? String else {return}
                        passengers.append(Passenger(name: name))
                    }
                }
            }
            complition!(passengers)
        }) { (error) in
            withError!(error)
            print(error)
        }
    }
    
}
