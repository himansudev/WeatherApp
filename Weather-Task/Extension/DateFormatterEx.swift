//
//  DateFormatterEx.swift
//  Weather-Task
//
//  Created by Himansu Sekhar Panigrahi on 07/01/25.
//

import Foundation

extension DateFormatter {
    static var shortTime: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}
