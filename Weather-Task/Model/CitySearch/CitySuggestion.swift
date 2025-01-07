//
//  City.swift
//  Weather-Task
//
//  Created by Himansu Sekhar Panigrahi on 07/01/25.
//

import Foundation

struct CitySuggestion: Codable,Identifiable {
    let name: String?
    let country: String?
    let state: String?
    let lat:Double?
    let long:Double?
    var id:String {
        (name ?? "") + (state ?? "") + (country ?? "")
    }
}

struct CityCoordinates{
    let lat:Double
    let long:Double
}
