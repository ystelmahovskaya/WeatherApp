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
    toggleActivityIndicator(on: true)
    getCurrentWeatherData()
    }

    func toggleActivityIndicator (on: Bool) {
    refreshButton.isHidden = on
        
        if on {
        activityIndicator.startAnimating()
        }
        else {
        activityIndicator.stopAnimating()
        }
    }

    lazy var weatherManager = APIWeatherManager(apiKey: "7d791308b9269bdfc5d5b62a4f5df95f")
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let coordinates = Coordinates(latitude: 57.871521, longitude: 11.925186 )
    
override func viewDidLoad() {
        super.viewDidLoad()
    
//    uses defauls structure initializer
//    let icon = WeatherIconManager.Rain.image
//    let currentWeather = CurrentWeather(temperature: 10.0, appearentTemperature: 5.0, humidity: 30, pressure: 1000, icon: icon)


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
    getCurrentWeatherData()
    
    
    
    }
    
 

    func updateUIWithCurrentWeather(currentWeather: CurrentWeather){
    
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.appearentTemperatureLabel.text = currentWeather.appearentTemperatureString
         self.temperatureLabel.text = currentWeather.temperatureString
         self.humidityLabel.text = currentWeather.humidityString
    }
    
    func getCurrentWeatherData(){
        weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
            self.toggleActivityIndicator(on: false)
            switch result{
            case .Success(let currentWeather):self.updateUIWithCurrentWeather(currentWeather: currentWeather)
            case .Failure(let error as NSError):
                let ac = UIAlertController(title: "Unable to get data", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                ac.addAction(okaction)
                self.present(ac, animated: true, completion: nil)
            default: break
            }
        }
    }
}

