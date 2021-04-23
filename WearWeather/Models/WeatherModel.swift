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
    
    var wearAdvice: String {
        if Int(temperature) < -25 {
            return """
Don't forget to keep yourself warm:
👤 wool hat + hood + scarf
👕 thermal underwear + sweater + down jacket + mittens
👖 thermal underwear + jeans/pants + down jumpsuit
🥾 wool socks + furry shoes
"""
        } else if -25 ... -15 ~= Int(temperature) {
            if conditionName.contains("rain") {
                return """
    Don't forget to keep yourself warm and don't forget your umbrella:
    👤 wool hat + hood + scarf
    👕 sweater + down jacket + mittens
    👖 thermal underwear + jeans/pants
    🥾 wool socks + warm boots
    """
            } else {
                return """
    Don't forget to keep yourself warm:
    👤 wool hat + hood + scarf
    👕 sweater + down jacket + mittens
    👖 thermal underwear + jeans/pants
    🥾 wool socks + warm boots
    """
            }
            
            
        } else if -14 ... -9 ~= Int(temperature) {
            if conditionName.contains("rain") {
                return """
Have a nice walk and don't forget your umbrella:
👤 hat + scarf
👕 sweater + down jacket + gloves
👖 thermal underwear (optional) + jeans/pants
🥾 warm socks + warm boots
"""
            }
            else {
                return """
    Have a nice walk:
    👤 hat + scarf
    👕 sweater + down jacket + gloves
    👖 thermal underwear (optional) + jeans/pants
    🥾 warm socks + warm boots
    """
            }
        } else if -8 ... -1 ~= Int(temperature) {
            if conditionName.contains("rain") {
                return """
have a nice walk and don't forget your umbrella:
👤 hat
👕 sweater + warm jacket/raincoat + gloves
👖 thermal underwear (optional) + jeans/pants
🥾 warm boots/rubber boots
"""
            }
            else {
                return """
    have a nice walk:
    👤 hat
    👕 sweater + warm jacket + gloves
    👖 thermal underwear (optional) + jeans/pants
    🥾 warm boots
    """
            }
        } else if 0 ... 14 ~= Int(temperature) {
            if conditionName.contains("rain") {
                return """
Don't forget umbrella!
👤 hat(optional)
👕 shirt + sweatshot/hoody + windbreaker/raincoat
👖 jeans/pants
🥾 boots/sneakers/rubber boots
"""} else {
    return """
👤 hat(optional)
👕 shirt + sweatshot/hoody + windbreaker
👖 jeans/pants
🥾 boots/sneakers
"""
}
            
        } else if 15 ... 23 ~= Int(temperature) {
            if conditionName.contains("rain")  {
                return """
            Don't forget umbrella!
            👤 SPF + cap
            👕 shirt + windbreaker/raincoat
            👖 jeans/pants
            🥾 boots/sneakers/rubber boots
            """
            }
            else {
                return """
👤 SPF 50+ + cap
👕 shirt + windbreaker
👖 jeans/pants
🥾 light boots/sneakers
"""}
        } else if Int(temperature) > 23 {
            if conditionName.contains("rain")  {
                return """
            Don't forget umbrella!
            👤 SPF + cap
            👕 shirt + raincoat
            👖 jeans/pants
            🥾 sneakers/rubber boots
            """
            }
            else {
                return """
👤 SPF 50+ + cap
👕 shirt
👖 jeans/pants/shorts
🥾 sneakers/sandals
"""
            }
        } else {
            return ""
        }
    }
}
