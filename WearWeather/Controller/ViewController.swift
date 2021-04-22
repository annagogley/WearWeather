//
//  ViewController.swift
//  WearWeather
//
//  Created by Аня Воронцова on 08.04.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempValue: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var descriptionWeather: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        cityTF.delegate = self
        weatherManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        cityTF.endEditing(true)
    }
    
    @IBAction func geoButtonPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
}

//MARK: - TF delegate methods
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type city name 🙃"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        textField.text = ""
        textField.placeholder = "Enter city name"
    }
}

//MARK: - WeatherManagerDelegate methods

extension ViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityName.text = weather.name
            self.tempValue.text = weather.tempString
            self.weatherIcon.image = UIImage(systemName: weather.conditionName)
            self.descriptionWeather.text = weather.description
        }
        print(weather.tempString)
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate methods

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}

