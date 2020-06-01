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
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textLabelConstraints: NSLayoutConstraint!
    
    var locationForButton: CGFloat?
    var locationForText: CGFloat?
    var coronaManager = CoronaManager()
    
    @IBAction func findButoonPressed(_ sender: UIButton) {
    }
    
    func animations() {
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseOut, animations: {
            self.findButtonBottomConstraints.constant += self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
            self.textLabelConstraints.constant -= self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.layer.cornerRadius = 10
        textLabel.layer.masksToBounds = true
        textLabel.backgroundColor = .white
        
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        textLabelConstraints.constant += view.bounds.height
        locationForText = textLabelConstraints.constant
        
        findButtonBottomConstraints.constant -= view.bounds.height
        locationForButton = findButtonBottomConstraints.constant

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
        findButtonBottomConstraints.constant = locationForButton!
        textLabelConstraints.constant = locationForText!
    }
}
