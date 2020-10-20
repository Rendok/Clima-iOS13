//
//  weatherManadger.swift
//  Clima
//
//  Created by Dmitry Grebenyuk on 15/9/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

class WeatherManager {
    
    private let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=4da1dbee3e3163b294bcadb350fae44b&units=metric"
    
    public var delegate: WeatherManagerDelegate?
    
    public func getWeather(for city: String) {
        let urlString = "\(weatherUrl)&q=\(city)"
        fetch(url: urlString)
    }
    
    public func getWeather(lat: Double, lon: Double) {
        let urlString = "\(weatherUrl)&lat=\(lat)&lon=\(lon)"
        fetch(url: urlString)
    }
    
    private func fetch(url urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let dataSafe = data {
                    if let weather = self.parseJSON(weatherData: dataSafe) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }

            task.resume()
        }
    }
    
    private func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weather = WeatherModel(id: decodedData.weather[0].id, cityName: decodedData.name, temperature: decodedData.main.temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
