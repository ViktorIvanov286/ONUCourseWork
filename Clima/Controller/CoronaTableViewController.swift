import UIKit

class CoronaViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var popManager = PopManager()
    var coronaManager = CoronaManager()
    var filteredArray: [Countries] = [Countries]()
    var searching: Bool = false
    var myRow: Int = 0
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()

    @objc func refresh(sender: UIRefreshControl) {
        coronaManager.fetchData {
            self.tableView.reloadData()
        }
        sender.endRefreshing()
    }
    
    
    @IBAction func moreButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "moreDetails", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        coronaManager.fetchData {
            self.tableView.reloadData()
        }
        
        searchBar.placeholder = "Search your country"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = myRefreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewAnimations()
    }
    
    //MARK: - Animations for TableView cells
    
    func tableViewAnimations() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.0, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}

//MARK: - UITableViewDataSource

extension CoronaViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredArray.count
        } else {
            return coronaManager.coronaCountries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCells", for: indexPath)
        if searching {
            cell.textLabel?.text = filteredArray[indexPath.row].Country
        } else {
            cell.textLabel?.text = coronaManager.coronaCountries[indexPath.row].Country
        }
        
//        print(cell.textLabel?.text)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension CoronaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myRow = indexPath.row
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            if searching {
                destination.coronaData = filteredArray[myRow]
            } else {
                destination.coronaData = coronaManager.coronaCountries[myRow]
            }
        }
    }
}

//MARK: - UISearchBarDelegate

extension CoronaViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = coronaManager.coronaCountries.filter({$0.Country.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
        tableViewAnimations()
        self.searchBar.endEditing(true) // Dismiss a keyboard
    }
}
