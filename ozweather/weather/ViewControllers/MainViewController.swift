

import UIKit

class MainViewController: UIViewController, cityListDelegate {
    func cityListReturn(_ data:[cityInfo]){
        citiesSelected = data.filter{$0.id != ""};
        getData();
        storeFavorite()
    }
    
    @IBOutlet weak var aTitle: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!

    @IBAction func refreshClk(_ sender: UIButton) {
        getData();
    }
    @IBAction func infoBtnClk(_ sender: UIButton) {
        switchViewControllerAbout(Name: "AboutViewController");
    }
    @IBAction func settingBtnClk(_ sender: UIButton) {
        switchViewControllersCity(Name: "cityList");
    }
    

    @IBOutlet weak var topvc: UIView!
    
    func storeFavorite() {
        var str1 = "";
        var str2 = "";
        for item in citiesSelected {
            str1 += item.id + ",";
            str2 += item.name + ",";
        }
        localStorageWrite(myKey: "id", value: str1);
        localStorageWrite(myKey: "name", value: str2);
    }
    func loadFavorite() {
        let str1 = localStorageRead(key: "id");
        let str2 = localStorageRead(key: "name");
        if str1.count > 0 {
        let nameArr = str2.components(separatedBy: ",");
        let idArr = str1.components(separatedBy: ",");
        citiesSelected = [];
        for i in 0..<idArr.count {
            citiesSelected.append(cityInfo(id: idArr[i], name: nameArr[i]))
        }
        }
    }
    func switchViewControllerAbout(Name: String) {
        let storyboard = UIStoryboard.init(name: Name, bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: Name)
        navigationController?.pushViewController(nav, animated: true)
    }
    
    func switchViewControllersCity(Name: String) {
        let storyboard = UIStoryboard.init(name: Name, bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: Name) as! cityList
        nav.delegate = self;
        nav.localCityList = citiesSelected;
        navigationController?.pushViewController(nav, animated: true)
    }

    // MARK: - pre display
    func getData() {
        self.spinner.startAnimating();
        WtArray = []; // clear up mem in case
        fcArrayCities = [];

        for thecity in citiesSelected {
            let theurl = theURL + thecity.id;
            let theForecastUrl = forcastUrl + thecity.id;
        getUserData(theurl) {  weatherData in
            do {
                WtArray.append(weatherData);
                geForecastDataBackground(theForecastUrl) { fcData in
                    fcArrayCities.append(fcData);
            }
                self.tableView.reloadData()
                self.spinner.stopAnimating();
            }
            catch {
                print ("Handle error")
            }
        }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "weather_background")!);
        loadFavorite(); // load fav cities from prev stored
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundView = nil;
        tableView.backgroundColor = UIColor.clear;
        aTitle.textColor = UIColor.white;
        DispatchQueue.global().async {
            rawData = loadJson(filename: "citylist")!; // background loading city names
        }
        getData();
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
}

