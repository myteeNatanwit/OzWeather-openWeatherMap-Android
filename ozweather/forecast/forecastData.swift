import Foundation
/*
 {
 dt: 1533448800,
 main: {
 temp: 16.62,
 temp_min: 14.24,
 temp_max: 16.62,
 pressure: 998.72,
 sea_level: 1016.33,
 grnd_level: 998.72,
 humidity: 62,
 temp_kf: 2.38
 },
 weather: [
 {
 id: 800,
 main: "Clear",
 description: "clear sky",
 icon: "01d"
 }
 ],
 clouds: {
 all: 0
 },
 wind: {
 speed: 5.13,
 deg: 1.50092
 },
 rain: { },
 sys: {
 pod: "d"
 },
 dt_txt: "2018-08-05 06:00:00"
 },
 */
var fcArrayCities : [fcDataTr] = [] // array of forcast for cities

struct fcMain: Codable {
    let temp: Float
    let temp_min: Float
    let temp_max: Float
  //  let pressure: Float
  //  let sea_level: Float
  //  let grnd_level: Float
    let humidity: Int
  //  let temp_kf: Float
}
struct City: Codable {
    let id: Int
}
struct fcWt: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct fcwindTr: Codable {
    let speed: Float
    let deg: Float
}
struct fccloudsTr: Codable {
    let all: Int
}

struct fc: Codable {
    let dt: Double
    let weather: [fcWt]
    let wind: fcwindTr
    let clouds: fccloudsTr
    let main: fcMain
    private enum CodingKeys: String, CodingKey {
        case dt
        case weather = "weather"
        case main = "main"
        case wind = "wind"
        case clouds = "clouds"
    }
}

struct fcDataTr: Codable {
    var fcArray: [fc]
    let cnt : Int
    let city : City
    private enum CodingKeys: String, CodingKey {
        case fcArray = "list"
        case city = "city"
        case cnt
    }
}
