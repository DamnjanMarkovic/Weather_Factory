//
//  WeatherImageProvider.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 5.12.21..
//

import UIKit



enum WeatherModes: String{
    case Clear
    case Rain
    case Clouds
    case Snow
    case Mist
    
}

struct WeatherImageProvider {

    static func getImageFromName(name: String, isDay: Bool) -> UIImage {
        
        switch isDay {
            case true:
                    switch name {
                        case "Clear":
                            return Constants.CLEAR_IMAGE!
                        case "Rain":
                            return Constants.RAIN_IMAGE!
                        case "Snow":
                            return Constants.SNOW_IMAGE!
                        case "Clouds":
                            return Constants.CLOUDS_IMAGE!
                        case "Mist":
                            return Constants.FOG_IMAGE!
                        default:
                            return Constants.MUSTACHE_IMAGE!
                    }
            case false:
                return Constants.NIGHT_IMAGE!
        }
        
    }
    
    
    
    static func getImageColor(name: String, isDay: Bool) -> UIColor {
        
        switch isDay {
            case true:
                    switch name {
                        case "Clear":
                            return Constants.CLEAR_IMAGE_COLOR
                        case "Rain":
                            return Constants.RAIN_IMAGE_COLOR
                        case "Snow":
                            return Constants.SNOW_IMAGE_COLOR
                        case "Clouds":
                            return Constants.CLOUDS_IMAGE_COLOR
                        case "Fog":
                            return Constants.FOG_IMAGE_COLOR
                        default:
                            return Constants.MUSTACHE_IMAGE_COLOR
                    }
            case false:
                return Constants.NIGHT_IMAGE_COLOR
        }
    }
    
}
