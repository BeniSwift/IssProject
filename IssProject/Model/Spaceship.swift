//
//  Spaceship.swift
//  IssProject
//
//  Created by hicham on 10/6/18.
//  Copyright © 2018 hicham. All rights reserved.
//

import Foundation

struct Spaceship {
    var position : (latitude: Double, longitude: Double) = (0,0)
    var timestamp : TimeInterval!
    
    init(_with data:Data) {
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        guard json != nil else {
            return
        }
        if let dictionary = json as? [String: Any] {
            if let iss_position = dictionary["iss_position"] as? [String: Any] {
                if let latitude = iss_position["latitude"] as? String {
                    self.position.0 = Double(latitude)!
                }
                if let longitude = iss_position["longitude"] as? String {
                    self.position.1 = Double(longitude)!
                }
            }
            if let timestamp = dictionary["timestamp"] as? NSNumber {
                self.timestamp = TimeInterval(timestamp)
            }
        }
    }
}
