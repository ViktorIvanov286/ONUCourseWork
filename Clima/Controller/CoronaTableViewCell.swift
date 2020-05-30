import UIKit

class CoronaTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var coronaImage: UIImageView!
    @IBOutlet weak var infected: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
