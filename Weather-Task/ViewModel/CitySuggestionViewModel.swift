//
//  CitySuggestionViewModel.swift
//  Weather-Task
//
//  Created by Himansu Sekhar Panigrahi on 07/01/25.
//

import Foundation
import Combine

class CitySuggestionViewModel: ObservableObject {
  
    @Published var city: String = ""
    var selectedCity: CitySuggestion?
    @Published var suggestions: [CitySuggestion] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var isNavigating: Bool = false
    
    private let api = WeatherAPI()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $city
            .debounce(
                for: .milliseconds(300),
                scheduler: RunLoop.main
            )  // Adds a delay to reduce API calls since we have chances of unnecessary API calls
            .removeDuplicates()
            .sink{ [weak self] query in
                if query.isEmpty{
                    self?.suggestions = []
                }
                guard let self = self,
                !query.isEmpty else {return}
                self.fetchCitySuggestion(for: query)
            }
            .store(in: &cancellables)
        
    }
}

//MARK: Network Calls
extension CitySuggestionViewModel{
    //Fetches City Suggestion
    func fetchCitySuggestion(for query: String){
        self.isLoading = true
        api.fetchCitySuggestion(for: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result{
                case .success(let suggestions):
                    self?.suggestions = suggestions
                    print(suggestions)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

