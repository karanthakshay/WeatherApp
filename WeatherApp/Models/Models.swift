//
//  Models.swift
//  WeatherApp
//
//  Created by Akshay A Karanth - (Digital) on 21/05/20.
//  Copyright © 2020 Akshay A Karanth - (Digital). All rights reserved.
//

import Foundation

struct Forecasts: Codable {
    let list: [Forecast]
}
struct Forecast: Codable {
    let main: Temperature
    let weather: [Weather]
    let dt_txt: String
}
class Temperature:Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}
class Weather:Codable {
    let main: String
    let description: String
    let icon: String
}
