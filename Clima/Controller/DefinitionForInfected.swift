import UIKit

class DefinitionForInfected: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var backgroundColors: [UIColor] = [#colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)]
    var definitions: [String] = ["hello", "eb;vweribvwei;rbuv", "Just a reminder that when Shakespeare was quarantined because of the plague, he wrote King Lear."]
    

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
            
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 15
        
        return cell
    }
    
    
}
