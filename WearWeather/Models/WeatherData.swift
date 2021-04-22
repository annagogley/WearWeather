//
//  WeatherData.swift
//  WearWeather
//
//  Created by Аня Воронцова on 21.04.2021.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main : Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}
