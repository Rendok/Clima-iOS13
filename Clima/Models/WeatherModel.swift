//
//  WeatherModel.swift
//  Clima
//
//  Created by Dmitry Grebenyuk on 16/9/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    var id: Int
    var cityName: String
    var temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var condition: String {
        switch id {
        case 200...299:
            return "cloud.bolt"
        case 300...399:
            return "cloud.drizzle"
        case 500...504:
            return "cloud.sun.rain"
        case 511:
            return "cloud.sleet"
        case 520...599:
            return "cloud.heavyrain"
        case 600...699:
            return "snow"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.sun"
        default:
            return "sun.max"
        }
    }
}
