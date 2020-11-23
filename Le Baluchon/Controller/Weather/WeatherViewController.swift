
import UIKit

class WeatherViewController: BaseViewController {
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
    
    
    // MARK: Methods - Internal
    
    @IBAction func didTapCityTextFieldButton() {
        displayCityWeather()
    }
    
    
    
    @IBAction func didTapNewyorkButton() {
        newYorkActivityIndicator.startAnimating()
        displaysWeatherDataFromCity(cityName: "new york", isCustomCity: false)
        
    }
    
    /// ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Weather"
        cityActivityIndicator.hidesWhenStopped = true
        newYorkActivityIndicator.hidesWhenStopped = true
        newyorkButton.layer.cornerRadius = 25
        textFieldButton.layer.cornerRadius = 25
        
        
        
    }
    
    
    // MARK: - Private
    
    // MARK: Properties - Private
    
    @IBOutlet private weak var newyorkButton: UIButton!
    @IBOutlet weak var textFieldButton: UIButton!
    @IBOutlet private weak var customCitySearchTextField: UITextField!
    @IBOutlet private weak var newyorkLabel: UILabel!
    @IBOutlet private weak var cityActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var newYorkActivityIndicator: UIActivityIndicatorView!
    
    
    
    
    private var cityInputNameSearchString: String? {
        guard let textValue = customCitySearchTextField.text else{
            
            return nil }
        return String(textValue)
    }
    
    
    
    // MARK: Methods - Private
    
    
    private func displayCityWeather() {
        guard let cityName = cityInputNameSearchString else {
            
            return
        }
        cityActivityIndicator.startAnimating()
        displaysWeatherDataFromCity(cityName: cityName, isCustomCity: true)
    }
    
    
    private let networkManager = NetworkManager()
    
    private func displaysWeatherDataFromCity(cityName: String, isCustomCity: Bool) {
        
        guard let url = getWeatherValuesURL(cityName: cityName) else {
            return
        }
        
        networkManager.fetch(url: url) { [weak self](result: Result<WeatherResponse,  NetworkManagerError>) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if isCustomCity {
                        self?.customCitySearchTextField.text = response.name
                    } else {
                        self?.newyorkLabel.text = response.name
                    }
                    
                    self?.weatherResponse = response
                    self?.performSegue(withIdentifier: "GoToCityWeatherDetailsSegue", sender: nil)
                    
                    self?.newYorkActivityIndicator.stopAnimating()
                    self?.cityActivityIndicator.stopAnimating()
                    
                    
                case .failure( _):
                    self?.alertManager.presentAlert(from: self!, message: "Could not get weather data informations")
                }
                self?.cityActivityIndicator.stopAnimating()
                self?.newYorkActivityIndicator.stopAnimating()
            }
            
        }
    }
    
    private var weatherResponse: WeatherResponse?
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        if let cityViewController = segue.destination as? CityViewController {
            cityViewController.weatherResponse = weatherResponse
            
        }
    }
    
    
    private func getWeatherValuesURL(cityName: String) -> URL? {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "http"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            .init(name: "q", value: cityName),
            .init(name: "appid", value: "022b0764cc4f75219db52fb5bb71cd2b"),
            .init(name: "units", value: "metric")
        ]
        
        return urlComponents.url
    }
    
    
    
    
    
    
    
}