
import UIKit

class SearchView: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
     var delegate:SearchChildDelegate?
    
    var paramData: [fcwtItem] = [];
    private var currentArray: [fcwtItem] = []; // for search result

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add City" ;
        currentArray = paramData;
        table.dataSource = self;
        table.delegate = self;
        searchBar.delegate = self
        print(paramData.count);
        alterLayout()
    }


    func alterLayout() {
        table.tableHeaderView = UIView()
        navigationItem.titleView = searchBar
        //searchBar.showsScopeBar = false // you can show/hide this dependant on your layout
        searchBar.placeholder = "Search City by Name"
    }

    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentArray.count
        //return 10 for testing
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell number: \(indexPath.row)!");
        let info = cityInfo(id: currentArray[indexPath.row].id.description, name: currentArray[indexPath.row].name);
        msgBox(mytitle: "Ozweater", mymessage: "Adding " + info.name + "to your favorite?") {
            print("ok pressed");
            self.delegate?.returnData(info);
        }
        self.table.deselectRow(at: indexPath, animated: true)

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        cell.nameLbl.text = currentArray[indexPath.row].name;
        cell.nameLbl.tag = currentArray[indexPath.row].id;
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentArray = paramData.filter({ paramData -> Bool in
            if searchText.isEmpty { return true }
            return paramData.name.lowercased().contains(searchText.lowercased())
        })
        table.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

