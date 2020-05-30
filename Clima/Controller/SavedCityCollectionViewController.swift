import UIKit

class SavedCityCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var cities: [CitiesWeather] = [CitiesWeather]()
    var backgroundColor: [UIColor] = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 0.5801028872, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)]
    var backgroundCellImage: [Any] = [Any]()
    var backgroundGifImage: [UIColor] = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 0.5801028872, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)]
    var myIsEditing: Bool = false
    var myRow: IndexPath?
    var selectedCity: String = ""
    
    var myFileManager = MyFileManager()
    
    func fetchData() {
        cities = DataBaseManager.share.savedCities!
    }
    
    func updateData() {
        fetchData()
        collectionView.reloadData() 
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell {
                    cell.isEditing = editing
                    myIsEditing = editing
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
        collectionView.backgroundColor = backgroundColor.randomElement()
        collectionView.reloadData()
    }
}

extension SavedCityCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CustomCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        
        cell.cityName.text = cities[indexPath.row].city
        
        if let fileName = cities[indexPath.row].city,
            let image = myFileManager.loadImageFromDiskWith(fileName: fileName) {
            cell.img.image = image
        }
        
        cell.index = indexPath
        cell.delegate = self
        
        return cell
    }
}

extension SavedCityCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        myRow = indexPath
        selectedCity = cities[indexPath.row].city!
        
        if myIsEditing {
            performSegue(withIdentifier: "GoToCamera", sender: self)
        } else {
            performSegue(withIdentifier: "showDetailsSaved", sender: self)
        }
    
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsSaved" {
            if let destination = segue.destination as? DetailsForSaved {
            destination.city = cities[myRow!.row]
            destination.index = myRow
            }
        }
        else if segue.identifier == "GoToCamera" {
            if let destination = segue.destination as? CameraViewController {
                destination.nameForImage = selectedCity
                destination.index = myRow
            }
        }
    }
}

extension SavedCityCollectionViewController: DeleteDataCellDelegate {
    func deleteData(index: Int) {
        DataBaseManager.share.delete(city: cities[index])
        cities.remove(at: index)
        collectionView.reloadData()
    }
}
