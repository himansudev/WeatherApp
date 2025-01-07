//
//  CitySuggestionView.swift
//  Weather-Task
//
//  Created by Himansu Sekhar Panigrahi on 07/01/25.
//

import SwiftUI

struct CitySuggestionView:View{
    
    @StateObject private var viewModel = CitySuggestionViewModel()
    
    var body: some View{
        NavigationView {
            VStack{
                HStack{
                    //Search Bar
                    /* .searchable modifier is not available in SwiftUI 3.0 that is why need custom view*/
                    SearchBar(text: $viewModel.city)
                    
                    
                    //Cancel Button
                    Button {
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil,
                            from: nil,
                            for: nil
                        )

                    } label: {
                        Text("Cancel")
                            .padding([.trailing],20)
                    }

                }
                
                
                
                // Show Suggestions
                if viewModel.suggestions.isEmpty {
                    
                    //No Results View
                    Spacer()
                    Text(viewModel.city.isEmpty ? "" : "No Results")
                        .foregroundStyle(.secondary)
                        .font(Font.headline)
                    Spacer()
                    
                    
                }else{
                    
                    
                    
                    //List View
                    List(viewModel.suggestions) { suggestion in
                        Button(action: {
                            viewModel.seenCities.append(suggestion)
                            viewModel.selectedCity = suggestion
                            viewModel.city = ""
                            viewModel.suggestions = []
                            viewModel.isNavigating = true
                                           
                        }) {
                            VStack(alignment: .leading) {
                                Text(suggestion.name ?? "NA")
                                    .font(.headline)
                                Text("\(suggestion.state ?? "NA"), \(suggestion.country ?? "NA")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
                
                // Show Forecast or Loading State
                if viewModel.isLoading {
                    ProgressView("Fetching Cities...")
                        .padding()
                }
                else if let errorMessage = viewModel.errorMessage {
                    
                    //Error View
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                    
                }
                
                NavigationLink("",
                               destination: WeatherView(
                                viewModel: WeatherViewModel(city: viewModel.selectedCity)),
                    isActive: $viewModel.isNavigating
                )
            }
            .navigationTitle("Search City")
        }
    }
    
}
