//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yuliia Stelmakhovska on 2017-08-04.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var appearentTemperatureLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    

    
@IBAction func refreshButtonTaped(_ sender: UIButton) {
    }


override func viewDidLoad() {
        super.viewDidLoad()
    
//    uses defauls structure initializer
    let icon = WeatherIconManager.Rain.image
    let currentWeather = CurrentWeather(temperature: 10.0, appearentTemperature: 5.0, humidity: 30, pressure: 1000, icon: icon)
  updateUIWithCurrentWeather(currentWeather: currentWeather)

//    let urlString = "https://api.darksky.net/forecast/7d791308b9269bdfc5d5b62a4f5df95f/37.8267,-122.4233"
//    let baseURL = URL(string: "https://api.darksky.net/forecast/7d791308b9269bdfc5d5b62a4f5df95f/")
//    let fullURL = URL(string: "37.8267,-122.4233", relativeTo: baseURL)
//    
//    let sessionConfiguration = URLSessionConfiguration.default
//    let session = URLSession(configuration: sessionConfiguration)
//    let request = URLRequest(url: fullURL!)
//    let dataTask = session.dataTask(with: fullURL!){(data,responce, error) in
//    
//    }
//    dataTask.resume()
    
    
    
    }

    func updateUIWithCurrentWeather(currentWeather: CurrentWeather){
    
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.appearentTemperatureLabel.text = currentWeather.appearentTemperatureString
         self.temperatureLabel.text = currentWeather.temperatureString
         self.humidityLabel.text = currentWeather.humidityString
    }
}

