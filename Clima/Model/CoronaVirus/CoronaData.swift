import Foundation


struct CoronaData: Codable {
    let Global: Global
    let Countries: [Countries]
}

struct Global: Codable {
    let TotalConfirmed: Int
    let NewConfirmed: Int
    let NewDeaths: Int
    let TotalDeaths: Int
    let NewRecovered: Int
    let TotalRecovered: Int
}

struct Countries: Codable {
    let Country: String
    let TotalConfirmed: Int
    let NewConfirmed: Int
    let TotalRecovered: Int
    let NewRecovered: Int
    let TotalDeaths: Int
    let NewDeaths: Int
}
