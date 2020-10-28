
import UIKit

class CityViewController: BaseViewController {
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
    
    var weatherResponse: WeatherResponse?
    var main: Main?
    var weather: Weather?
    var clouds: Clouds?
    var sys: Sys?
    
    
    // MARK: Methods - Internal
    
    
    /// ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cityLabel.text = weatherResponse?.name
        weatherLabel.text = sys?.country
        
        
    }
    
    // MARK: - Private
    
    // MARK: Properties - Private
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var hightLowLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: Methods - Private
    
    @IBAction private func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
   
}
