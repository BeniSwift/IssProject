//
//  SpaceshipManager.swift
//  IssProject
//
//  Created by hicham on 10/6/18.
//  Copyright © 2018 hicham. All rights reserved.
//

import Foundation

struct SpaceshipManager {
    
    func getSpaceship(complition:((_ spaceship:Spaceship) -> Void)?,withError:((_ error:Error) -> Void)?){
        HTTPRequestMaker.doRequest(_to: ISS_POSITION_URL, _using: HTTPRequestMethods.Get.rawValue, _with: [:], completion: { (data) in
            let spaceship = Spaceship(_with: data)
            complition!(spaceship)
        }) { (error) in
            withError!(error)
            print(error)
        }
    }
    
    func getSpaceshipPassesFor(position:(lat:Double,long:Double),complition:((_ issPasses:[(duration:Int,risetime:TimeInterval)]) -> Void)?,withError:((_ error:Error) -> Void)?){
        HTTPRequestMaker.doRequest(_to: ISS_PASSES_URL, _using: HTTPRequestMethods.Get.rawValue, _with: ["lat":position.0,"lon":position.1,"n":NUMBER_OF_PASSES], completion: { (data) in
            var issPasses : [(duration:Int,risetime:TimeInterval)] = []
            guard data != nil else {
                print("error at geting passes data")
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let dictionary = json as? [String: Any] {
                if let response = dictionary["response"] as? [[String: Any]] {
                    for pass in response{
                        guard let duration = pass["duration"] as? Int, let risetime = pass["risetime"] as? NSNumber else {return}
                        issPasses.append((duration:duration,risetime:TimeInterval(risetime)))
                    }
                }
            }
            complition!(issPasses)
        }) { (error) in
            withError!(error)
        }
    }
    
}
