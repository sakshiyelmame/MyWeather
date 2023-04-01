//
//  Weather.swift
//  MyWeather
//
//  Created by Sakshi Yelmame on 18/03/23.
//

import Foundation
struct WeatherRes: Codable {
    let latitude : Float
    let longitude : Float
    let timezone : String
    let currently : CurrentlyWeather
    let hourly : HourlyWeather
    let daily : dailyWeather
    let offset : Float
}
struct CurrentlyWeather : Codable {
    let time : Int
    let summary : String
    let icon : String
    let precipIntensity : Double
    let precipProbability : Double
    let precipType : String?
    let temperature : Double
    let apparentTemperature : Double
    let dewPoint : Double
    let humidity : Double
    let pressure : Double
    let windSpeed : Double
    let windGust : Double
    let windBearing : Int
    let cloudCover : Double
    let uvIndex : Int
    let visibility : Int
    let ozone : Double
}
struct HourlyWeather : Codable {
    let summary : String
    let icon : String
    let data : [HourlyWeatherEntry]
}
struct HourlyWeatherEntry : Codable {
    let time : Int
    let summary : String
    let icon : String
    let precipIntensity : Double
    let precipProbability : Double
    let precipType : String?
    let temperature : Double
    let apparentTemperature : Double
    let dewPoint : Double
    let humidity : Double
    let pressure : Double
    let windSpeed : Double
    let windGust : Double
    let windBearing : Int
    let cloudCover : Double
    let uvIndex : Int
    let visibility : Double
    let ozone : Double
}
struct dailyWeather : Codable {
    let summary : String
    let icon : String
    let data : [dailyWeatherEntry]
}
struct dailyWeatherEntry : Codable {
    let time : Int
    let summary : String
    let icon : String
    let sunriseTime : Int
    let sunsetTime : Int
    let moonPhase : Double
    let precipIntensity : Double
    let precipIntensityMax : Double
    let precipIntensityMaxTime : Int?
    let precipProbability : Double
    let precipType : String?
    let temperatureHigh : Double
    let temperatureHighTime : Int
    let temperatureLow : Double
    let temperatureLowTime : Int
    let apparentTemperatureHigh : Double
    let apparentTemperatureHighTime : Int
    let apparentTemperatureLow : Double
    let apparentTemperatureLowTime : Int
    let dewPoint : Double
    let humidity : Double
    let pressure : Double
    let windSpeed : Double
    let windGust : Double
    let windGustTime : Int
    let windBearing : Int
    let cloudCover : Double
    let uvIndex : Int
    let uvIndexTime : Int
    let visibility : Double
    let ozone : Double
    let temperatureMin : Double
    let temperatureMinTime : Int
    let temperatureMax : Double
    let temperatureMaxTime : Int
    let apparentTemperatureMin : Double
    let apparentTemperatureMinTime : Int
    let apparentTemperatureMax : Double
    let apparentTemperatureMaxTime : Int
}

