
import Foundation
import UIKit

extension forecast: UITableViewDataSource, UITableViewDelegate {
    func getDate(dt: Double) -> String {
        let date = NSDate(timeIntervalSince1970: dt)
        
        let dayTimePeriodFormatter = DateFormatter()
        //dayTimePeriodFormatter.dateFormat = "EEEE dd-MM-yy"
        dayTimePeriodFormatter.dateFormat = "EEEE"
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        
        print( " _ts value is \(dt)")
        print( " _ts value is \(dateString)")
        return dateString;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath) as! forecastCell
        cell.theDT.text = getDate(dt: (localTable?.fcArray[indexPath.row].dt)!);
        cell.temp.text = (localTable?.fcArray[indexPath.row].main.temp.description)! + "c";
        cell.minmax.text = (localTable?.fcArray[indexPath.row].main.temp_min.description)! + " - " + (localTable?.fcArray[indexPath.row].main.temp_max.description)!;
        
        cell.cond.text = localTable?.fcArray[indexPath.row].weather[0].main;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (localTable?.fcArray.count)!;
    }
    
}
