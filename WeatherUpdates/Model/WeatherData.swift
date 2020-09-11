//
//  WeatherData.swift
//  WeatherUpdates
//
//  Created by 123 on 09/09/20.
//  Copyright © 2020 vamsiOSDev. All rights reserved.
//

import Foundation
// the names used for variables should match the data from url

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather] // based on the type in JSON data tree
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
