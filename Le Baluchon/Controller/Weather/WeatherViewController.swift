
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
    @IBOutlet private weak var textFieldButton: UIButton!
    @IBOutlet private weak var customCitySearchTextField: UITextField!
    @IBOutlet private weak var newyorkLabel: UILabel!
    @IBOutlet private weak var cityActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var newYorkActivityIndicator: UIActivityIndicatorView!
    
    
    let weatherManager = WeatherManager()
    
    
    
    
    // MARK: Methods - Private
    
    
    private func displayCityWeather() {
        cityActivityIndicator.startAnimating()
        weatherManager.displaysWeatherDataFromCity(
            cityName: customCitySearchTextField.text!
        ) { [weak self]  (result) in
            
            DispatchQueue.main.async {
                switch result {
                
                case .success(let response):
                    self?.prepare(for: <#UIStoryboardSegue#>, sender: <#Any?#>)
                    
                case .failure(let error):
                    self?.presentAlert()
                    
                }
                
            }
            
        }
        
    }
    
    private func presentAlert() {
        let alertController = UIAlertController(title: "Error", message: "Failed", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
 
    
    
    private var weatherResponse: WeatherResponse?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        if let cityViewController = segue.destination as? CityViewController {
            cityViewController.weatherResponse = weatherResponse
            
        }
    }
    
    
   
    
    
    
    
    
    
    
}
