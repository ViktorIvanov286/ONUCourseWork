import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var totalConfirmed: UILabel!
    @IBOutlet weak var newConfirmed: UILabel!
    @IBOutlet weak var totalRecovered: UILabel!
    @IBOutlet weak var nreRecovered: UILabel!
    @IBOutlet weak var totalDeaths: UILabel!
    @IBOutlet weak var newDeaths: UILabel!
    
    
    @IBOutlet weak var suggestion: UILabel!
    
    var percents: Double = 0.0
    var stringPercents: String = ""
    
    var coronaData: Countries?
    var popManager = PopManager()
    
    func percent(infected: Double, population: Double) -> Double {
        let x = (infected * 100) / population
        return x
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        countryName.text = coronaData?.Country
        totalConfirmed.text = "\((coronaData?.TotalConfirmed)!)"
        newConfirmed.text = "\((coronaData?.NewConfirmed)!)"
        totalRecovered.text = "\((coronaData?.TotalRecovered)!)"
        nreRecovered.text = "\((coronaData?.NewRecovered)!)"
        totalDeaths.text = "\((coronaData?.TotalDeaths)!)"
        newDeaths.text = "\((coronaData?.NewDeaths)!)"
        
        popManager.fetchData(country: (countryName.text)!) {
            self.percents = self.percent(infected: Double((self.coronaData?.TotalConfirmed)!), population: Double(self.popManager.popPopulation[0].population))
            
            if self.percents <= 25.0 {
                self.view.backgroundColor = .green
            } else if self.percents > 25.0 && self.percents < 50.0 {
                self.view.backgroundColor = .yellow
            } else {
                self.view.backgroundColor = .red
            }
            
            self.stringPercents = String(format: "%.3f", self.percents)
            
            self.suggestion.text = "\(self.stringPercents)% infected in \((self.coronaData?.Country)!). The current population of \((self.coronaData?.Country)!) is \(self.popManager.popPopulation[0].population)."
            
        }
    }
}
