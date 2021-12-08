//
//  Constants.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 4.12.21..
//


import UIKit

struct Constants {
    
    
    static let WEATHER_URL_BASE_STRING =  "https://api.openweathermap.org/data/2.5/weather?appid=219476f806931eb3272535a511f85dea&units=metric"
    
    static let WEATHER_FORECAST_URL_BASE_STRING =  "https://api.openweathermap.org/data/2.5/forecast?appid=219476f806931eb3272535a511f85dea&units=metric"

    static let JSON_LOCAL_FILE_NAME = "cities"
    
    static let RAIN_IMAGE =  UIImage(systemName: "cloud.rain")
    static let RAIN_IMAGE_COLOR =  UIColor.blue
    
    static let CLEAR_IMAGE =  UIImage(systemName: "sun.max")
    static let CLEAR_IMAGE_COLOR =  UIColor.yellow
    
    static let CLOUDS_IMAGE =  UIImage(systemName: "cloud")
    static let CLOUDS_IMAGE_COLOR =  UIColor.white
    
    static let SNOW_IMAGE =  UIImage(systemName: "snowflake")
    static let SNOW_IMAGE_COLOR =  UIColor.white
    
    static let FOG_IMAGE =  UIImage(systemName: "cloud.fog")
    static let FOG_IMAGE_COLOR =  UIColor.blue
    
    static let MUSTACHE_IMAGE =  UIImage(systemName: "mustache")
    static let MUSTACHE_IMAGE_COLOR =  UIColor.red
    
    static let NIGHT_IMAGE =  UIImage(systemName: "moon.stars")
    static let NIGHT_IMAGE_COLOR =  UIColor.black
    
    static let MILLISECNODS_IN_A_DAY = 86400

}
