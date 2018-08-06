

import Foundation
func geForecastDataBackground( _ url: String, callback:  @escaping (_ result: fcDataTr) -> ()) {
    let myUrl = URL(string: url);
    var request = URLRequest(url: myUrl!)
    let session = URLSession.shared;
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    DispatchQueue.global().async { // run in background
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let result = data, error == nil else {
                print("\(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
            }
            let responseString = String(data: result, encoding: .utf8)
            guard let data = data else {
                print("Forecast Error: No data to decode")
                return
            }
            
            guard let forecastData = try? JSONDecoder().decode(fcDataTr.self, from: data) else {
                print("Error: Couldn't decode data into forecast array " + url)
                return
            }
            print("ok " + url);
               callback(forecastData)
        }
        task.resume() }
}
