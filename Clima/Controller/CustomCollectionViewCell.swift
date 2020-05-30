import UIKit

protocol DeleteDataCellDelegate {
    func deleteData(index: Int)
}

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var delete: UIButton! {
        didSet {
            delete.isHidden = !isEditing
        }
    }
    
    var isEditing: Bool = false {
        didSet {
            delete.isHidden = !isEditing
        }
    }
    
    var delegate: DeleteDataCellDelegate?
    var index: IndexPath?
    
    @IBAction func deleteButton(_ sender: UIButton) {
        delegate?.deleteData(index: (index?.row)!)
    }
}
