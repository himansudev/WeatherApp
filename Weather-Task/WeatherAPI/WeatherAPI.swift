//
//  WeatherAPI.swift
//  Weather-Task
//
//  Created by Himansu Sekhar Panigrahi on 07/01/25.
//

import Foundation

struct WeatherAPI{
    //This is not the way to store api key. It could be done using env variables, keychain etc
    static let apiKey = "95acde229fe57dc126b4f9ce6cb0d271"
    static let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
    
    
    func fetchWeather(
        for city: CityCoordinates,
        completion: @escaping (Result<WeatherResponse, Error>) -> ()
    ){
        guard
            let encodedURLString = "\(WeatherAPI.baseURL)?lat=\(city.lat)&lon=\(city.long)&units=metric&appid=\(WeatherAPI.apiKey)"
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedURLString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

//City Suggestions
extension WeatherAPI{
    func fetchCitySuggestion(
        for query: String,
        completion: @escaping (Result<[CitySuggestion], Error>) -> ()
    ){
        guard let encodedURLString = "https://api.openweathermap.org/geo/1.0/direct?q=\(query)&limit=5&appid=\(WeatherAPI.apiKey)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let url = URL(string: encodedURLString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error{
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            do{
                let citySuggestions = try JSONDecoder().decode([CitySuggestion].self, from: data)
                completion(.success(citySuggestions))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
