import Foundation


class PopManager {
    let popURL = "https://restcountries.eu/rest/v2/name/"
    var popPopulation: [PopData] = [PopData]()

    func fetchData(country: String, complete: @escaping () -> ()) {
        var coutryName: String = ""
        
//        let newCountry: String = country.replacingOccurrences(of: "\"", with: "")
        for letter in country {
            if letter == " " {
                coutryName += "%20"
            } else {
                coutryName += "\(letter)"
            }
            print(coutryName)
        }
        
        let url = URL(string: popURL + "\(coutryName)?fullText=true")
        
        print(coutryName)
        print(popURL + "\(coutryName)?fullText=true")

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
