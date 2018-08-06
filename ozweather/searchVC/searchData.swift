

import Foundation
import UIKit
protocol SearchChildDelegate{
    func returnData(_ data: cityInfo)
}

var rawData : [fcwtItem] = [];
var filteredData : [fcwtItem] = [];

struct ResponseData: Decodable {
    let list: [fcwtItem]
    private enum CodingKeys: String, CodingKey {
        case list = "list"
    }
}
struct fcwtItem : Decodable {
    let id: Int
    let name: String
    let country: String
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case country = "country"
    }
}

func loadJson(filename fileName: String) -> [fcwtItem]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(ResponseData.self, from: data)
            return jsonData.list
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

