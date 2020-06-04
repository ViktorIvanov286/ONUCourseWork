import UIKit

class DefinitionForInfected: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var backgroundColors: [UIColor] = [#colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)]
    var definitions: [String] = ["Green backgound means that less than 25% of population is infected by COVID-19 in the country. Remember: only the one who goes through the door will exit quarantine!", "Yellow background means that quantity of infected by COVID-19 more than 25% and less than 50% of population in the country. \n Try on jeans from time to time. Pajamas are insidious.", "Red background means that the quantity of infected by COVID_19 is more than 50% of population in the country. \n Just a reminder that when Shakespeare was quarantined because of the plague, he wrote King Lear."]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        let nibName = UINib(nibName: "DefinitionCollectionViewCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "DefinitionCells")
    }
}

//MARK: - UICollectionViewDataSource

extension DefinitionForInfected: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return definitions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefinitionCells", for: indexPath) as! DefinitionCollectionViewCell
        
        cell.textLabel.text = definitions[indexPath.row]
        cell.backgroundColor = backgroundColors[indexPath.row]
        
        cell.textLabel.layer.cornerRadius = 10
        cell.textLabel.layer.masksToBounds = true
            
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 15
        
        return cell
    }
    
    
}
