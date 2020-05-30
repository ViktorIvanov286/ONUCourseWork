import Foundation


class PopManager {
    let popURL = "https://restcountries.eu/rest/v2/name/" // {country}?fullText=true
    var popPopulation: [PopData] = [PopData]()

    func fetchData(country: String, complete: @escaping () -> ()) {
        var coutryName: String = ""

        
        for letter in country {
            if letter == " " {
                coutryName += "%20"
            } else {
                coutryName += "\(letter)"
            }
        }
        
        
        let url = URL(string: popURL + "\(coutryName)?fullText=true")

        URLSession.shared.dataTask(with: url!) { (data, response, error) in

            do {
                let downloadedData = try JSONDecoder().decode([PopData].self, from: data!)
                self.popPopulation = downloadedData

                DispatchQueue.main.async {
                    complete()
                }
            } catch {
                print("Error!")
            }
        }.resume()
    }
}
