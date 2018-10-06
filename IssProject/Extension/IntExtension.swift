//
//  IntExtension.swift
//  IssProject
//
//  Created by hicham on 10/6/18.
//  Copyright © 2018 hicham. All rights reserved.
//

import Foundation

extension Int {
    // Convert a number of seconds to a full time format
    func secondsToFullTime() -> String {
        let seconds = self
        var mins = 0
        var hours = 0
        var secs = seconds
        if seconds >= 60 {
            mins = Int(seconds / 60)
            secs = seconds - (mins * 60)
            if mins >= 60 {
                hours = Int(mins / 60)
                mins = mins - (hours * 60)
            }
        }
        
        return String(format: "%02dh:%02dmin:%02ds",hours, mins,secs)
    }
}
