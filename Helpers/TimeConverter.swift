//
//  TimeConverter.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 3.12.21..
//

import Foundation

struct TimeConverter {
    
    
    static func getTimeFromMS(time: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.local
        formatter.dateFormat = "HH"
        return formatter.string(from: date)
    }
    
    static func getDayNameFromMS(time: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.local
        formatter.dateFormat = "HH:mm, d.MM"
        formatter.dateFormat = "EE"
        return formatter.string(from: date)
        
    }
        
}

