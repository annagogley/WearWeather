//
//  WeatherManager.swift
//  WearWeather
//
//  Created by Аня Воронцова on 21.04.2021.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=3dd24617e8aea45e3bc5fba456ab1c1e&units=metric"
    
    func fetchWeather(cityName: String) {
        if SpecificWordCount(str: cityName).0 == 1 {
            let urlString = "\(weatherURL)&q=\(cityName)"
            performRequest(urlString)
        } else {
            let concatCityName = SpecificWordCount(str: cityName).1.joined(separator: "%20")
            let urlString = "\(weatherURL)&q=\(concatCityName)"
            performRequest(urlString)
        }
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String) {
        //creating url
        if let url = URL(string: urlString) {
            //creating url session
            let session = URLSession(configuration: .default)
            //give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    let dataString = String(data: safeData, encoding: .utf8)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let feelsLike = decodedData.main.temp
            let description = decodedData.weather[0].description
            
            let weatherModel = WeatherModel(name: name, id: id, temperature: temp, description: description, feelsLike: feelsLike)
            return weatherModel
        }
        catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    func SpecificWordCount(str:String) ->(Int, [String]) {
        let components = str.components(separatedBy: .whitespacesAndNewlines)
        let words = components.filter { !$0.isEmpty }
        return (words.count, words)
        
    }
    
}
