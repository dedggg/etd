import SwiftUI
import Alamofire

// WeatherView
public struct WeatherView: View {
    
    @State var weather: Weather? = nil
    var key: String
    var city: String
    
    public init(key: String, city: String) {
        self.key = key
        self.city = city
    }
    
    //  Интерфейс компонента WeatherView
    public var body: some View {
        ZStack {
            Color.white.opacity(0.2)
            if weather == nil {
                ProgressView()
            } else {
                VStack {
                    AsyncImage(url: URL(string: weather!.current.condition.icon)) { image in
                        image
                    } placeholder: {
                        ProgressView()
                    }
                }
                .padding()
            }
        }
        .frame(width: 250, height: 223)
        .onAppear(perform: {
            Api(host: "http://api.weatherapi.com/v1").performRequest(url: "current.json?key=\(key)&q=\(city)") { ( result: Weather? ) in
                guard let result = result else {
                    return
                }
                self.weather = result
            }
        })
    }
}

public struct Weather: Codable {
    var current: WeatherCurrent
}

public struct WeatherCurrent: Codable {
    var temp_c: Double
    var condition: WeatherCondition
}

public struct WeatherCondition: Codable {
    var text: String
    var icon: String
}
