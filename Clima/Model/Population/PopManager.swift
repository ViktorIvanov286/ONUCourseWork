import Foundation

class PopManager {
    let popURL = "https://restcountries.eu/rest/v2/name/"
    var popPopulation: [PopData] = [PopData]()
    var newString: String = ""
    
    

    func fetchData(country: String, complete: @escaping () -> ()) {
//        let countryName = country.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        
        let countryName = setRightCountry(country: country)
        
        let url = URL(string: popURL + "\(countryName)?fullText=true")

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
    
    
    private func setRightCountry(country: String) -> String {
        
        var letters: [Character] = []
        
        for letter in country {
            letters.append(letter)
        }
        
        if let i = letters.firstIndex(of: "(") {
            letters[i] = " "
        }
        
        var newString: String = ""
        
        for i in 0..<letters.count {
            if letters[i] == " " && letters[i + 1] == " " {
                break
            } else {
                newString.append(letters[i])
            }
        }
        
        let countryName = newString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        
        print(countryName)
        
        return countryName
    }
}
