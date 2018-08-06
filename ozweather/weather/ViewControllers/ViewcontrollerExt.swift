
import Foundation
import UIKit

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func switchViewControllers(Name: String, thisData: Weather) {

        let storyboard = UIStoryboard.init(name: Name, bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: Name) as! forecast
        nav.weatherData = thisData;
        for fcItem in fcArrayCities {
            if fcItem.city.id == thisData.id {
                nav.fcData = fcItem;
                break;
            }
        }
        //nav.delegate = self;
        navigationController?.pushViewController(nav, animated: true)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell number: \(indexPath.row)!");
      
        switchViewControllers(Name: "forecast", thisData: WtArray[indexPath.row]);
        self.tableView.deselectRow(at: indexPath, animated: true)

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WtArray.count;

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! cityCell
        
        cell.city.text = WtArray[indexPath.row].name;
        cell.temp.text = String(WtArray[indexPath.row].main.temp.description) + " c";
        cell.cond.text = WtArray[indexPath.row].weather[0].main;
        var minmax = String(WtArray[indexPath.row].main.temp_min);
        minmax += " - ";
        minmax += String(WtArray[indexPath.row].main.temp_max);
        cell.minmax.text = minmax;
        let thisurl = iconUrl + WtArray[indexPath.row].weather[0].icon + ".png";
        cell.icon.downloadedFrom(url: thisurl);
        cell.contentView.backgroundColor = UIColor.clear;
        cell.accessoryType = .none;
        return cell;
    }



}
