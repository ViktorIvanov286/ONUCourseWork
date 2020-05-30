import UIKit

class CoronaGlobalViewController: UIViewController {
    
    @IBOutlet weak var totalConfirmed: UILabel!
    @IBOutlet weak var newConfirmed: UILabel!
    @IBOutlet weak var totalDeaths: UILabel!
    @IBOutlet weak var newDeaths: UILabel!
    @IBOutlet weak var totalRecovered: UILabel!
    @IBOutlet weak var newRecovered: UILabel!
    @IBOutlet weak var button: UIButton!

    var coronaManager = CoronaManager()
    
    @IBAction func findButoonPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true

        coronaManager.fetchData {
            self.totalConfirmed.text = "\(self.coronaManager.coronaGlobal?.TotalConfirmed ?? 0)"
            self.newConfirmed.text = "\(self.coronaManager.coronaGlobal?.NewConfirmed ?? 0)"
            self.totalDeaths.text = "\(self.coronaManager.coronaGlobal?.TotalDeaths ?? 0)"
            self.newDeaths.text = "\(self.coronaManager.coronaGlobal?.NewDeaths ?? 0)"
            self.totalRecovered.text = "\(self.coronaManager.coronaGlobal?.TotalRecovered ?? 0)"
            self.newRecovered.text = "\(self.coronaManager.coronaGlobal?.NewRecovered ?? 0)"
        }
    }
}
