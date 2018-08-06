
import UIKit
protocol cityListDelegate {
    func cityListReturn(_ data:[cityInfo])
}

class cityList: UITableViewController, SearchChildDelegate {
    func returnData(_ data: cityInfo) {
//        if !localCityList.contains(where: { $0.id == data.id }) {
//            localCityList.append(data);
//            self.tableView.reloadData();
//    }
        var found = false;
        for item in localCityList {
            if item.id == data.id {
                found = true;
                break;
            }
        }
        if !found {
            localCityList.append(data);
            self.tableView.reloadData();
        }
    }
    var delegate: cityListDelegate?
    var localCityList :[cityInfo] = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        showToast(message: "Swipe to delete enabled!");
        self.title = "Favorite" ;
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let play = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        
        navigationItem.rightBarButtonItems = [add, play]
        //rawData = loadJson(filename: "citylist")!;
        print(rawData.count)
        filteredData = rawData.filter({rawData -> Bool in
            rawData.country == "AU"
        })
        //rawData = [];
        print(filteredData.count);
    }
    @objc func addTapped () {
        switchViewControllersSearch(Name: "SearchView", thisData: filteredData);
    }
    @objc func doneTapped() {
        print("Done " + localCityList.count.description);
        //citiesSelected = localCityList;
        delegate?.cityListReturn(localCityList);
    }
    
    func switchViewControllersSearch(Name: String, thisData: [fcwtItem]) {
        let storyboard = UIStoryboard.init(name: Name, bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: Name) as! SearchView
        nav.paramData = thisData
        nav.delegate = self;
        navigationController?.pushViewController(nav, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return localCityList.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! cityInfoCell
        cell.cityName.text = localCityList[indexPath.row].name;
       
        return cell
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
    
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        
        let delAction = UIContextualAction(style: .normal, title:  "Del", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.localCityList.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade);
            print("delete");
            success(true)
        })
        delAction.image = UIImage(named: "cancel")
        delAction.backgroundColor = .red;
        return UISwipeActionsConfiguration(actions: [delAction])
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
