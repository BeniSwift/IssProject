//
//  SpaceshipNotifier.swift
//  IssProject
//
//  Created by hicham on 10/6/18.
//  Copyright © 2018 hicham. All rights reserved.
//

import Foundation

protocol SpaceshipNotifaierDelegate {
    func spaceshipNewPosition(spaceship:Spaceship)
    func spaceshipSyncWithError(error:Error)
}

class SpaceshipNotifier {
    var timer : Timer!
    var delegate : SpaceshipNotifaierDelegate?
    
    init(timeInterval:TimeInterval = ISS_SYNC_INTERVAL) {
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(syncSpaceship), userInfo: nil, repeats: true)
    }
    
    @objc func syncSpaceship()
    {
        let manager = SpaceshipManager()
        manager.getSpaceship(complition: { (spaceship) in
            self.delegate?.spaceshipNewPosition(spaceship: spaceship)
        }) { (error) in
            self.delegate?.spaceshipSyncWithError(error: error)
        }
    }
    
    func stopSync(){
        self.timer.invalidate()
    }
}
