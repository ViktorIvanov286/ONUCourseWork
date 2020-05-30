import UIKit

class CoronaGlobalViewController: UIViewController {
    
    @IBOutlet weak var totalConfirmed: UILabel!
    @IBOutlet weak var newConfirmed: UILabel!
    @IBOutlet weak var totalDeaths: UILabel!
    @IBOutlet weak var newDeaths: UILabel!
    @IBOutlet weak var totalRecovered: UILabel!
    @IBOutlet weak var newRecovered: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var findButtonConstraints: NSLayoutConstraint!
    @IBOutlet weak var findButtonBottomConstraints: NSLayoutConstraint!
    
    var location: CGFloat?
    var coronaManager = CoronaManager()
    
    @IBAction func findButoonPressed(_ sender: UIButton) {
    }
    
    func animations() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.findButtonBottomConstraints.constant += self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        findButtonBottomConstraints.constant -= view.bounds.height
        location = findButtonBottomConstraints.constant

        coronaManager.fetchData {
            self.totalConfirmed.text = "\(self.coronaManager.coronaGlobal?.TotalConfirmed ?? 0)"
            self.newConfirmed.text = "\(self.coronaManager.coronaGlobal?.NewConfirmed ?? 0)"
            self.totalDeaths.text = "\(self.coronaManager.coronaGlobal?.TotalDeaths ?? 0)"
            self.newDeaths.text = "\(self.coronaManager.coronaGlobal?.NewDeaths ?? 0)"
            self.totalRecovered.text = "\(self.coronaManager.coronaGlobal?.TotalRecovered ?? 0)"
            self.newRecovered.text = "\(self.coronaManager.coronaGlobal?.NewRecovered ?? 0)"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        findButtonBottomConstraints.constant = location!
    }
}
