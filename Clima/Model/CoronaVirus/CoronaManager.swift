import Foundation

class CoronaManager {

    let coronaURL = "https://api.covid19api.com/summary"
    var coronaGlobal: Global?
    var coronaCountries: [Countries] = [Countries]()
    
    func fetchData(complete: @escaping () -> ()) {
        let url = URL(string: coronaURL)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            do {
                let downloadedData = try JSONDecoder().decode(CoronaData.self, from: data!)
                self.coronaCountries = downloadedData.Countries
                self.coronaGlobal = downloadedData.Global
                
                DispatchQueue.main.async {
                    complete()
                }
            } catch {
                print("Error!")
            }
        }.resume()
    }
}
