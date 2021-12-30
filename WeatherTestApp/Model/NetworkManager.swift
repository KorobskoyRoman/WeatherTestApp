//
//  NetworkManager.swift
//  WeatherTestApp
//
//  Created by Roman Korobskoy on 30.12.2021.
//

import Foundation

struct NetworkManager {
    
    func fetchWeather(completionHandler: @escaping (Weather) -> Void) {
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=45.039247&long=38.913338"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("\(apiKey)", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print(String(describing: error))
                return }
//            print(String(data: data, encoding: .utf8) ?? "")
            if let weather = self.parseJSON(withData: data) {
                print(weather)
                completionHandler(weather)
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> Weather? {
        
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let weather = Weather(weatherData: weatherData) else { return nil }
            
            return weather
        } catch let error as NSError {
            print("JSON decode error: " ,error.localizedDescription)
        }
        return nil
    }
}