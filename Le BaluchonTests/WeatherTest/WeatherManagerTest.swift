import XCTest
@testable import Le_Baluchon


class WeatherManagerTest: XCTestCase {
    
    private var weatherManager: WeatherManager!
    
   
    override func setUp() {
        super.setUp()
        weatherManager = WeatherManager()
    }
    
    
   
    func test_givenInvalidResponse_whenGetWeatherDataFromCity_thenFailedToGetWeatherDataFromCity () throws {
        
        let networkManagerMock = NetworkManagerMock(
            resultSuccessType: WeatherResponse.self,
            resultFetch: .failure(.unknownError)
        )
        
        let weatherManager = WeatherManager(networkManager: networkManagerMock)
        
        weatherManager.getWeatherDataFromCity(cityName: "New York") { (result) in
            
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .failedToGetWeatherDataInformation)
            }
            
        }
    }
    
    
    func test_givenCity_whenDisplayCity_thenGetCorrectCityName() throws {
        
        let weatherResponse = WeatherResponse(
            coord: Coord(lon: -74.006, lat: 40.7143),
            
            weather:[Weather(id: 801,
                              main: "Clouds",
                              weatherDescription: "few clouds",
                              icon: "02n")],
            
            base: "stations",
            
            main: Main(temp: 2.82,
                       feelsLike: -2.42,
                       tempMin: 0.56,
                       tempMax: 5,
                       pressure: 1014,
                       humidity: 81),
            
            visibility: 10000,
            
            wind: Wind(speed: 4.63,
                       deg: 60,
                       gust: 0.0),
            
            clouds: Clouds(all: 20),
            
            dt: 1610704810,
            
            sys: Sys(type: 1,
                     id: 4610,
                     country: "US",
                     sunrise: 1610713063,
                     sunset: 1610747576),
            
            timezone: -18000,
            
            id: 5128581,
            
            name: "New York",
            
            cod: 200)

        let networkManagerMock = NetworkManagerMock(
            resultSuccessType: WeatherResponse.self,
            resultFetch: .success(weatherResponse)
        )

        let weatherManager = WeatherManager(networkManager: networkManagerMock)

        weatherManager.getWeatherDataFromCity(cityName: "New York") { (result) in
            switch result {
            case .success(let formattedWeatherData):
                XCTAssertEqual(formattedWeatherData.cityName, "New York")
            case .failure:
               XCTFail()
            }
        }
    }
    
    
    func test_givenCity_whenDisplayCity_thenGetFailedCityName() throws {
        
        let weatherResponse = WeatherResponse(
            coord: Coord(lon: -74.006, lat: 40.7143),
            
            weather:[Weather(id: 801,
                              main: "Clouds",
                              weatherDescription: "few clouds",
                              icon: "02n")],
            
            base: "stations",
            
            main: Main(temp: 2.82,
                       feelsLike: -2.42,
                       tempMin: 0.56,
                       tempMax: 5,
                       pressure: 1014,
                       humidity: 81),
            
            visibility: 10000,
            
            wind: Wind(speed: 4.63,
                       deg: 60,
                       gust: 0.0),
            
            clouds: Clouds(all: 20),
            
            dt: 1610704810,
            
            sys: Sys(type: 1,
                     id: 4610,
                     country: "US",
                     sunrise: 1610713063,
                     sunset: 1610747576),
            
            timezone: -18000,
            
            id: 5128581,
            
            name: "Marseille",
            
            cod: 200)

        let networkManagerMock = NetworkManagerMock(
            resultSuccessType: WeatherResponse.self,
            resultFetch: .success(weatherResponse)
        )

        let weatherManager = WeatherManager(networkManager: networkManagerMock)

        weatherManager.getWeatherDataFromCity(cityName: "New York") { (result) in
            switch result {
            case .success:
                XCTFail()
                
            case .failure(let error):
                XCTAssertEqual(error, .failedToGetWeatherDataInformation)
            }
        }
    }
    
    

    
    
}
