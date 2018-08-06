/*
 test(
 {
 coord: {
 lon: 145.26,
 lat: -37.85
 },
 weather: [
 {
 id: 520,
 main: "Rain",
 description: "light intensity shower rain",
 icon: "09d"
 }
 ],
 base: "stations",
 main: {
 temp: 12,
 pressure: 1010,
 humidity: 76,
 temp_min: 12,
 temp_max: 12
 },
 visibility: 10000,
 wind: {
 speed: 7.7,
 deg: 360
 },
 clouds: {
 all: 90
 },
 dt: 1533355200,
 sys: {
 type: 1,
 id: 8193,
 message: 0.0046,
 country: "AU",
 sunrise: 1533330990,
 sunset: 1533368043
 },
 id: 2176566,
 name: "Bayswater",
 cod: 200
 }
 )
 
 */

import UIKit

class forecast: UIViewController {
    @IBOutlet weak var icon: UIImageView!

    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var cond: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var minmax: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var cloud: UILabel!
    @IBOutlet weak var tableView: UITableView!
    


    var weatherData: Weather? = nil;
    var fcData: fcDataTr? = nil; // array of forcast with 40 element
    var localTable: fcDataTr? = nil; // 5 days only
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Forecast" ;
        tableView.delegate = self;
        tableView.dataSource = self;
        if let wd = weatherData {
            city.text = wd.name;
            temp.text = wd.main.temp.description + " c";
            cond.text = wd.weather[0].main;
            var minmaxV = "Min ";
            minmaxV += String(wd.main.temp_min) + "c";
            minmaxV += " - Max ";
            minmaxV += String(wd.main.temp_max) + "c";
            minmax.text = minmaxV;
            let thisurl = iconUrl + wd.weather[0].icon + ".png";
            icon.downloadedFrom(url: thisurl);
            wind.text = "Wind speed " + wd.wind.speed.description + " m/s";
            cloud.text = String(wd.clouds.all) + " % cloudy";
        }
        // now prepare 5 days forecast, 5 days x 8 (3 hours)
        localTable = fcData;
        localTable?.fcArray = [];
        localTable?.fcArray.append((fcData?.fcArray[0])!); // day 1
        localTable?.fcArray.append((fcData?.fcArray[7])!); // day 2
        localTable?.fcArray.append((fcData?.fcArray[15])!); // day 3
        localTable?.fcArray.append((fcData?.fcArray[24])!); // day 4
        localTable?.fcArray.append((fcData?.fcArray[31])!); // day 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
