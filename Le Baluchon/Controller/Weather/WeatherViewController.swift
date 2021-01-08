
import UIKit

class WeatherViewController: BaseViewController {
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
   
    
    // MARK: Methods - Internal
    
    @IBAction func didTapCityTextFieldButton() {
        displayCityWeather(
            cityName: customCitySearchTextField.text,
            activityIndicatorView: cityActivityIndicator
        )
    }
    
    
    
    @IBAction func didTapNewyorkButton() {
        displayCityWeather(
            cityName: "New York",
            activityIndicatorView: newYorkActivityIndicator
        )
        
        
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
    //let alertManager = AlertManager()
    
    
    
    
    // MARK: Methods - Private
    
    
    private func displayCityWeather(cityName: String?, activityIndicatorView: UIActivityIndicatorView) {
        activityIndicatorView.startAnimating()
        
        weatherManager.getWeatherDataFromCity(
            cityName: cityName
        ) { [weak self]  (result) in
            
            DispatchQueue.main.async {
                activityIndicatorView.stopAnimating()
                
                
                switch result {
                
                case .failure:
                    self?.presentAlert()
                
                case .success(let formattedWeatherData):
                    self?.formattedWeatherData = formattedWeatherData
                    self?.performSegue(withIdentifier: "GoToCityWeatherDetailsSegue", sender: self)
                    
               
                }
                
            }
            
        }
        
    }
    
    // TODO: Remove and use AlertManager
    private func presentAlert() {
        let alertController = UIAlertController(title: "Error", message: "Failed", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
 
    
    
    private var formattedWeatherData: FormattedWeatherData?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        if let cityViewController = segue.destination as? CityViewController {
            cityViewController.formattedWeatherData = formattedWeatherData
            
        }
    }
    
    
   
    
    
    
    
    
    
    
}
