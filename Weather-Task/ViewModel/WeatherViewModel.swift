//
//  WeatherViewModel.swift
//  Weather-Task
//
//  Created by Himansu Sekhar Panigrahi on 07/01/25.
//

import Foundation

class WeatherViewModel:ObservableObject{
    @Published var forecasts: [Forecast] = []
    @Published var isLoading:Bool = false
    @Published var errorMessage:String?
    let city:CitySuggestion?
    private let api = WeatherAPI()
    
    var currentTemp:Int? {
        if let temp = self.forecasts.first?.main?.temp{
            return Int(temp)
        }
        return nil
    }
    
    init(city:CitySuggestion?){
        self.city = city
    }
    
    func fetchWeather(){
        isLoading = true
        errorMessage = nil
        
        let cityCoordinates = CityCoordinates(lat: self.city?.lat ?? 0, long: self.city?.long ?? 0)
        api.fetchWeather(for: cityCoordinates) { [weak self] result in
            self?.isLoading = false
            
            switch result{
            case .success(let weatherResponse):
                self?.forecasts = weatherResponse.list ?? []
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    
}
