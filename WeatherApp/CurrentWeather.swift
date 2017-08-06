//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Yuliia Stelmakhovska on 2017-08-04.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature: Double
    let appearentTemperature: Double
    let humidity: Double
    let pressure: Double
    let icon: UIImage
}
extension CurrentWeather{
    var pressureString: String{
        return "\(Int(pressure))"+"mm"
    }
    var humidityString: String{
        return "\(Int(humidity))"+"%"
    }
    var temperatureString: String{
        return "\(Int(temperature))"+"˚C"
    }
    var appearentTemperatureString: String{
        return "\(Int(appearentTemperature))"+"˚C"
}
}
