//
//  SearchBar.swift
//  Weather-Task
//
//  Created by Himansu Sekhar Panigrahi on 07/01/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let placeholder: String = "Search for a city"
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
    }
}
