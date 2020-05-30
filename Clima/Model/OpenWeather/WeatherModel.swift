import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let humidity: Int
    let wind: Double
    let pressure: Int
    let tempMin: Double
    let tempMax: Double
    let cod: Int
    
    
    
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var backgroundImage: String {
        switch conditionId {
        case 200...232:
            return "CloudsAndSun"
        case 300...321:
            return "Clouds"
        case 500...531:
            return "Clouds"
        case 600...622:
            return "Clouds"
        case 701...781:
            return "Clouds"
        case 800:
            return "CloudsAndSun"
        case 801...804:
            return "CloudsAndSun"
        default:
            return "CloudsAndSun"
        }
    }
}
