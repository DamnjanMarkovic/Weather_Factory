//
//  TimeConverter.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 3.12.21..
//

import Foundation

struct TimeConverter {
    
    static func CheckIfIsDay(positionOfTheDay: Int, time: TimeInterval,
                             sunrise: TimeInterval,
                             sunset: TimeInterval) -> Bool {
        var counter = positionOfTheDay
        
        if counter == -1 {
            counter = 0
        }
        
        if (time > sunrise + (Double(Constants.MILLISECNODS_IN_A_DAY) * Double(counter))
                            &&
            time < sunset + (Double(Constants.MILLISECNODS_IN_A_DAY) * Double(counter))) {
                        
                return true
        }
        else {
            return false
        }
        
    }

    
    
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
    
    static func getMSFromDate(time: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.local
        formatter.dateFormat = "HH:mm, d.MM"
        formatter.dateFormat = "EE"
        return formatter.string(from: date)
        
    }

    
}

