//
//  WeatherData.swift
//  Clima
//
//  Created by Dmitry Grebenyuk on 16/9/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    var name: String
    var main: Main
    var weather: [Weather]
    
}

struct Main: Decodable {
    var temp: Double
}

struct Weather: Decodable {
    var id: Int
}
