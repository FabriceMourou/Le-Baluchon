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
        
        let weatherManager = WeatherManager()
        
        weatherManager.getWeatherDataFromCity(cityName: nil) { (result) in
            switch result {
            case .success:
                XCTFail()
                
            case .failure(let error):
                XCTAssertEqual(error, .failedToConvertValue)
            }
        }
    }
    
    

    func test_givenAlwaysFailUrlComponent_whenGetUrl_getFailedToCreateUrlForWeather() {
        let failUrlComponents = URLComponentsMock()
        let weatherManager = WeatherManager(urlComponents: failUrlComponents)
        
        weatherManager.getWeatherDataFromCity(cityName: "New York") { (result) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .failedToCreateUrlForWeather)
            }
        }
    }
    
    
    
    func test_givenCity_whenDisplayCity_thenFailedToGetInformationForWeather() throws {
        
        let weatherResponse = WeatherResponse(
            coord: Coord(lon: -74.006, lat: 40.7143),

            weather:[Weather(id: 801,
                              main: "Clouds",
                              weatherDescription: "few clouds",
                              icon: "02n")],

            base: "stations",

            main: nil,

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
            case .success:
                XCTFail()
          
            case .failure( let error):
                XCTAssertEqual(error, .failedToGetInformationForWeather)
            }
        }
    }
    
    
    
    func test_givenCitasdasdy_whenDisplayCity_thenFailedToGetInformationForWeather() throws {

        let failUrlComponentMock = URLComponentsMock()
        let weatherManager = WeatherManager(urlComponents: failUrlComponentMock)

        weatherManager.getWeatherDataFromCity(cityName: "New York") { (result) in
            switch result {
            case .success:
                XCTFail()
          
            case .failure( let error):
                XCTAssertEqual(error, .failedToCreateUrlForWeather)
            }
        }
    }
    
    
    func test_givenCitasdasdasdasdy_whenDisplayCity_thenFailedToGetInformationForWeather() throws {

        let failUrlComponentMock = URLComponentsMock()
        let weatherManager = WeatherManager(urlComponents: failUrlComponentMock)
        
        weatherManager.getWeatherIconImage(iconId: "123123"){ (result) in
            switch result {
            case .success:
                XCTFail()
          
            case .failure( let error):
                XCTAssertEqual(error, .failedToCreateUrlForWeatherIconImageData)
            }
        }
        
    }
    
    
    func test_givenCitasdasdasdasdasdasdy_whenDisplayCity_thenFailedToGetInformationForWeather() throws {
        
        
        let networkManagerMock = NetworkManagerMock(
            resultSuccessType: WeatherResponse.self,
            resultFetchData: .success(Data())
        )
        
        let weatherManager = WeatherManager(networkManager: networkManagerMock)
        
        weatherManager.getWeatherIconImage(iconId: "123123"){ (result) in
            switch result {
            case .success(let result):
                XCTAssertNotNil(result)
                
                
            case .failure:
                XCTFail()
            }
        }
    }
    
    
    func test_givenCitasdasdasdasasdadasdasdy_whenDisplayCity_thenFailedToGetInformationForWeather() throws {
        
        
        let networkManagerMock = NetworkManagerMock(
            resultSuccessType: WeatherResponse.self,
            resultFetchData: .failure(.badStatusCode)
        )
        
        let weatherManager = WeatherManager(networkManager: networkManagerMock)
        
        weatherManager.getWeatherIconImage(iconId: "123123"){ (result) in
            switch result {
            case .success:
                XCTFail()
                
    
                
            case .failure(let error):
                XCTAssertEqual(error, .failedToGetWeatherIconImageData)
            }
        }
    }
    
    
    
}
