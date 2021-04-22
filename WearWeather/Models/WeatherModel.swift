//
//  WeatherModel.swift
//  WearWeather
//
//  Created by Аня Воронцова on 21.04.2021.
//

import Foundation

struct WeatherModel {
    let name: String
    let id: Int
    let temperature: Double
    let description: String
    let feelsLike: Double
    
    var tempString: String {
        return String(Int(temperature))
    }
    
    var feelsString: String {
        return String(feelsLike.rounded())
    }
    
    var conditionName: String {
        switch id {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.rain"
        case 500...501:
            return "cloud.sun.rain"
        case 502...504, 520...531:
            return "cloud.heavyrain.fill"
        case 511:
            return "cloud.sleet"
        case 600...622:
            return "snow"
        case 701...762:
            return "cloud.fog"
        case 771, 781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801:
            return "cloud.sun"
        case 802...804:
            return "cloud"
        default:
            return "aqi.low"
        }
    }
}
