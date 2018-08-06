
let theURL = "https://api.openweathermap.org/data/2.5/weather?&appid=59098b0f3bd1953d615623ebc3b52e43&&units=metric&id=";
let forcastUrl = "http://api.openweathermap.org/data/2.5/forecast?appid=59098b0f3bd1953d615623ebc3b52e43&&units=metric&id="
let iconUrl = "http://openweathermap.org/img/w/";
var WtArray: [Weather] = []; // original array for selected cities weather data
var citiesSelected :[cityInfo] = [
cityInfo(id:"2158177", name:"Melbourne"),
cityInfo(id:"2147714", name:"Sydney"),
cityInfo(id:"2174003", name:"Brisbane")
]; // cities selected

struct cityInfo {
    var id: String
    var name: String
}
struct Wt: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
struct mainTr: Codable {
    let temp: Float
    let pressure: Int
    let humidity: Int
    let temp_min: Int
    let temp_max: Int
}
struct windTr: Codable {
    let speed: Float
    let deg: Float
}
struct cloudsTr: Codable {
    let all: Int
}
//    struct coord: Codable{
//        let lon: Float
//        let lat: Float
//    }
//    let visibility: String

//    let dt: CLong
//    struct sys: Codable{
//        let type: Int
//        let id: Int
//        let message: Float
//        let country: String
//        let sunrise: Int
//        let sunset: Int
//    }
struct Weather: Codable {


    private enum CodingKeys: String, CodingKey {
        case base
        case id
        case name
        case weather = "weather"
        case main = "main"
        case wind = "wind"
        case clouds = "clouds"
    }
    let weather: [Wt]
    let base: String
    let main: mainTr
    let wind: windTr
    let clouds: cloudsTr

    let id: Int
    let name: String

}
