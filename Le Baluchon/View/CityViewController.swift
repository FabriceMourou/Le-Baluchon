
import UIKit

class CityViewController: BaseViewController {
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
    
    var weatherResponse: WeatherResponse?
    var weather: Weather?
    
    // MARK: Methods - Internal
    
    
    /// ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let unformattedMainTemperature = weatherResponse?.main?.temp else { return }
        temperatureLabel.text = weatherValuesFormatter.getFormattedTemperature(from: unformattedMainTemperature)
        
        guard let unformattedFeelsLikeTemperature = weatherResponse?.main?.feelsLike else { return }
        feelsLikeLabel.text = weatherValuesFormatter.getFormattedTemperature(from: unformattedFeelsLikeTemperature)
            
        guard let unformattedHightTemperature = weatherResponse?.main?.tempMax else { return }
        hightTemperatureLabel.text = weatherValuesFormatter.getFormattedTemperature(from: unformattedHightTemperature)
        
        guard let unformattedLowTemperature = weatherResponse?.main?.tempMin else { return }
        lowTemperatureLabel.text = weatherValuesFormatter.getFormattedTemperature(from: unformattedLowTemperature)
        
        guard let unformattedCloudinessPercentage = weatherResponse?.clouds?.all else { return}
        percentageCloudinessLabel.text = weatherValuesFormatter.getFormattedPercentage(from: Double(unformattedCloudinessPercentage))
        
        guard let unformattedHumidityPercentage = weatherResponse?.main?.humidity else { return}
        percentageHumidityLabel.text = weatherValuesFormatter.getFormattedPercentage(from: Double(unformattedHumidityPercentage))
        
        cityLabel.text = weatherResponse?.name
        countryLabel.text = weatherResponse?.sys?.country
        longitudeLabel.text = weatherResponse?.coord?.lon?.description
        latitudeLabel.text = weatherResponse?.coord?.lat?.description
        
      
           
        
    }
    
    
    // MARK: - Private
    
    // MARK: Properties - Private
    
    private let weatherValuesFormatter = WeatherValuesFormatter()
    
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
    @IBOutlet private weak var weatherMainLabel: UILabel!
    
    
    // MARK: Methods - Private
    
    @IBAction private func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
   
}


class WeatherValuesFormatter {
    func getFormattedTemperature(from unformattedTemperature: Double) -> String? {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        numberFormatter.roundingMode = .halfDown
        guard let formattedNumber =  numberFormatter.string(from: unformattedTemperature as NSNumber) else { return nil }
        
        return formattedNumber +  "°c"
    
    }
    
    func getFormattedPercentage(from unformattedPercentage: Double) -> String? {
        let percentageFormatter = NumberFormatter()
        guard let formattedPercentage = percentageFormatter.string(from: unformattedPercentage as NSNumber) else { return nil }
        return formattedPercentage +  "%"
    }
    
 

}

