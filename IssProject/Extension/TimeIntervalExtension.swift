//
//  TimeIntervalExtension.swift
//  IssProject
//
//  Created by hicham on 10/6/18.
//  Copyright © 2018 hicham. All rights reserved.
//

import Foundation

extension TimeInterval {
    func stringFromTimeInterval()->String{
        let ms = Int(self.truncatingRemainder(dividingBy: 1)*1000)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour,.minute,.second]
        return "\(formatter.string(from: self)!).\(ms)"
    }
    
    func toStringDate() -> String {
        
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm" //Specify your format that you want
        return dateFormatter.string(from: date)
    }
}
