
import UIKit

class CityViewController: BaseViewController {
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
    
    var formattedWeatherData: FormattedWeatherData?
    
    
    // MARK: Methods - Internal
    
    
    /// ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        assignWeatherDataInformation()
        assignCityInformation()
        assignWeatherIconInformation()
        
    }
    
    
    
    
    // MARK: - Private
    
    // MARK: Properties - Private
    
    
    private let weatherManager = WeatherManager()
    private let alertManager = AlertManager()
    
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
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    @IBOutlet private weak var weatherIconImageView: UIImageView!
    
    
    // MARK: Methods - Private
    
    @IBAction private func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
    private func assignWeatherDataInformation() {
        guard let formattedWeatherData = formattedWeatherData else { return }
        
        temperatureLabel.text = formattedWeatherData.temperature
        feelsLikeLabel.text = formattedWeatherData.feelLikeTemperature
        hightTemperatureLabel.text = formattedWeatherData.highTemperature
        lowTemperatureLabel.text = formattedWeatherData.lowTemperature
        percentageCloudinessLabel.text = formattedWeatherData.percentageCloudiness
        percentageHumidityLabel.text = formattedWeatherData.percentageHumidity
        
    }
    
    
    private func assignCityInformation() {
        guard let formattedWeatherData = formattedWeatherData else { return }
        
        cityLabel.text = formattedWeatherData.cityName
        countryLabel.text = formattedWeatherData.cityCountry
        longitudeLabel.text = formattedWeatherData.longitude
        latitudeLabel.text = formattedWeatherData.latitude
    }
    
    
    private func assignWeatherIconInformation() {
        
        guard let formattedWeatherData = formattedWeatherData else { return }
        
        
        weatherDescriptionLabel.text = formattedWeatherData.description
        
        
        guard let iconId = formattedWeatherData.iconId else { return }
        
        weatherManager.getWeatherIconImage(iconId: iconId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let iconImageData):
                    guard let iconImage = UIImage(data: iconImageData) else { return }
                    self?.weatherIconImageView.image = iconImage
                case .failure:
                    guard let self = self else { return }
                    self.alertManager.presentAlert(from: self, message: "Failed to get icon image data")
                }
            }
        }
    }
}







