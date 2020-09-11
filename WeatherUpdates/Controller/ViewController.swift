//
//  ViewController.swift
//  WeatherUpdates
//
//  Created by 123 on 09/09/20.
//  Copyright © 2020 vamsiOSDev. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var goToMapBtn: UIButton!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    var mapLatitude: CLLocationDegrees?
    var mapLongitude: CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self // always to write at top of viewDidLoad.
        locationManager.requestWhenInUseAuthorization() // add this in info.plist too
       // locationManager.startUpdatingLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        
        if let lati = mapLatitude, let long = mapLongitude{
            weatherManager.fetchWeather(latitude: lati, longitude: long)
        }
    }
    
    @IBAction func userLocationBtnClicked(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func goBackToMapBtn(_ sender: UIButton)
    {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}

//MARK: - UITextField Delegate

extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton)
    {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Here weather info is displayed
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else{
            textField.placeholder = "Type city name here"
            return false
        }
    }
}

//MARK: - Weather Manager Delegate
extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        //UI is updated only on main thread
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }

    }
}

//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation() // to make userlocationBtn work
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
