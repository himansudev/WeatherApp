//
//  WeatherView.swift
//  Weather-Task
//
//  Created by Himansu Sekhar Panigrahi on 07/01/25.
//

import SwiftUI

struct WeatherView: View{
    
    @StateObject var viewModel:WeatherViewModel
    
    var body: some View{
        VStack(spacing: 7){
            
            //City Name
            Text(viewModel.city?.name ?? "Unknown City")
                .font(SwiftUI.Font.headline)
            
            
            //Temprature Label
            if let temp = viewModel.currentTemp{
                Text("\(temp)°")
                    .font(.largeTitle)
            }
            else{
                Text(viewModel.isLoading ? "" : "N/A")
                    .font(.largeTitle)
            }
            
            
            // Show Forecast or Loading State
            if viewModel.isLoading {
                ProgressView("Fetching weather...")
                    .padding()
            }
            
            // Error Message
            else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            }
            
            // Forecast List
            else if !viewModel.forecasts.isEmpty {
                List(viewModel.forecasts, id: \.date) { forecast in
                    VStack(
                        alignment: .leading,
                        spacing:20
                    ){
                        Text(forecast.getDate())
                            .font(.headline)
                        HStack{
                            Text(forecast.weather?.first?.description?.capitalized ?? "N/A")
                            Spacer()
                            Text(forecast.main?.getTemp() ?? Const.notAvailable)
                                .fontWeight(.bold)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Weather")
        .onAppear{
            viewModel.fetchWeather()
        }
    }
    
}



