
import UIKit

class CityViewController: BaseViewController {
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
    
    var weatherResponse: WeatherResponse?
   
    
    // MARK: Methods - Internal
    
    
    /// ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        assignTemperatureInformation()
        assignweatherInformation()
        assignCityInformation()
        assignWeatherIconInformation()
        
    }
    
    
    
    
    // MARK: - Private
    
    // MARK: Properties - Private
    
    private let weatherValuesFormatter = WeatherValuesFormatter()
    private let networkManager = NetworkManager()
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var hightTemperatureLabel: UILabel!
    @IBOutlet private weak var lowTemperatureLabel: UILabel!
    @IBOutlet private weak var percentageCloudinessLabel: UILabel!
    @IBOutlet private weak var percentageHumidityLabel: UILabel!
    @IBOutlet private weak var longitudeLabel: UILabel!
    @IBOutlet private weak var latitudeLabel: UILabel!
    @IBOutlet private weak var weatherIconLabel: UILabel!
    @IBOutlet private weak var weatherIconImageView: UIImageView!
    
    
    // MARK: Methods - Private
    
    @IBAction private func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    private func assignTemperatureInformation() {
        guard let main = weatherResponse?.main else { return }
        
        if let unformattedMainTemperature = main.temp {
            temperatureLabel.text = weatherValuesFormatter.getFormattedTemperature(from: unformattedMainTemperature)
        }
        
        if let unformattedFeelsLikeTemperature = main.feelsLike {
            feelsLikeLabel.text = weatherValuesFormatter.getFormattedTemperature(from: unformattedFeelsLikeTemperature)
        }
        
        
        if let unformattedHightTemperature = main.tempMax {
            hightTemperatureLabel.text = weatherValuesFormatter.getFormattedTemperature(from: unformattedHightTemperature)
        }
        
        
        if let unformattedLowTemperature = main.tempMin {
            lowTemperatureLabel.text = weatherValuesFormatter.getFormattedTemperature(from: unformattedLowTemperature)
        }
    }
    
    private func assignweatherInformation() {
        if let unformattedCloudinessPercentage = weatherResponse?.clouds?.all {
            percentageCloudinessLabel.text = weatherValuesFormatter.getFormattedPercentage(from: Double(unformattedCloudinessPercentage))
        }
        
        if let unformattedHumidityPercentage = weatherResponse?.main?.humidity {
            percentageHumidityLabel.text = weatherValuesFormatter.getFormattedPercentage(from: Double(unformattedHumidityPercentage))
        }
    }
    
    private func assignCityInformation() {
        cityLabel.text = weatherResponse?.name
        countryLabel.text = weatherResponse?.sys?.country
        longitudeLabel.text = weatherResponse?.coord?.lon?.description
        latitudeLabel.text = weatherResponse?.coord?.lat?.description
    }
    
    
    private func assignWeatherIconInformation() {
        weatherIconLabel.text = weatherResponse?.weather?.first?.weatherDescription
        guard
            let iconId = weatherResponse?.weather?.first?.icon,
            let iconUrl = URL(string: "http://openweathermap.org/img/wn/\(iconId)@2x.png")
        else { return }
        
        networkManager.fetchData(url: iconUrl) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let iconImageData):
                    let iconImage = UIImage(data: iconImageData)
                    self?.weatherIconImageView.image = iconImage
                    
                case .failure(let error):
                    print ("failure")
                   
                }
            }
            
        }
        
    }
    
    
        
       
        
    }
    
    





