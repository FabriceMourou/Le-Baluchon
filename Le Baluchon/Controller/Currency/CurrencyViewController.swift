import UIKit

class CurrencyViewController: BaseViewController {
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
    // MARK: Methods - Internal
    
    @IBAction func didTapSwapCurrenciesButton() {
        swap(&sourceCurrency, &targetCurrency)
    }
    

    
    @IBAction func didTapOnConvertButton() {
        convert()
    }
    
    
     
    
    /// ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Currency"
        currencyActivityIndicator.hidesWhenStopped = true
        roundConvertButton()
        roundSwapCurrenciesButton()
        roundCurrencySymbolLabels()
    }
    
    
    
    // MARK: - Private
    
    // MARK: Properties - Private
    
    @IBOutlet private weak var convertButton: UIButton!
    @IBOutlet private weak var valueToConvertTextField: UITextField!
    @IBOutlet private weak var convertedValueLabel: UILabel!
    @IBOutlet private weak var sourceCurrencySymbolLabel: UILabel!
    @IBOutlet private weak var targetCurrencySymbolLabel: UILabel!
    @IBOutlet private weak var swapCurrenciesButton: UIButton!
    @IBOutlet private weak var currencyActivityIndicator: UIActivityIndicatorView!
    
    
    
    // MARK: Methods - Private
    
    private func roundConvertButton () {
        convertButton.layer.cornerRadius = 50
        convertButton.layer.borderColor = UIColor.yellow.cgColor
        convertButton.layer.borderWidth = 2
    }
    
    private func roundSwapCurrenciesButton () {
        swapCurrenciesButton.layer.cornerRadius = 20
        swapCurrenciesButton.layer.borderColor = UIColor.yellow.cgColor
        swapCurrenciesButton.layer.borderWidth = 2
    }
    
    private func roundCurrencySymbolLabels () {
        for index in 0..<currencySymbolLabels.count {
            
            let currencyLabel = currencySymbolLabels[index]
            
            currencyLabel.layer.cornerRadius = 20
            currencyLabel.layer.borderWidth = 2
            currencyLabel.layer.borderColor = UIColor.yellow.cgColor
            
        }
    }
    
    private func convert() {
        guard let valueToConvert = valueToConvert else {
            alertManager.presentAlert(from: self, message: "Could not get value to convert")
            return
        }
        currencyActivityIndicator.startAnimating()
        convertValueWithRate(value: valueToConvert, sourceCurrency: sourceCurrency, targetCurrency: targetCurrency)
        
    }
    
    private var currencySymbolLabels: [UILabel] {
        [
            sourceCurrencySymbolLabel,
            targetCurrencySymbolLabel
        ]
    }
    
    private var valueToConvert: Double? {
        guard let textValue = valueToConvertTextField.text else { return nil }
        return Double(textValue)
    }
    
    
    private var sourceCurrency: Currency = .euro {
        didSet {
            sourceCurrencySymbolLabel.text = sourceCurrency.symbol
        }
    }
    
    private var targetCurrency: Currency = .dollar {
        didSet {
            targetCurrencySymbolLabel.text = targetCurrency.symbol
        }
    }
    
    
    private let networkManager = NetworkManager()
    
    private func convertValueWithRate(value: Double, sourceCurrency: Currency, targetCurrency: Currency)   {
        
        
        guard let url = getConvertValueWithRateURL() else {
            
            print("Could not create URL for currency conversion")
            return
        }
        
        networkManager.fetch(url: url) { [weak self] (result: Result<CurrencyResponse, NetworkManagerError>) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("Success")
                    
                    guard
                        let sourceRate = response.rates[sourceCurrency.code],
                        let targetRate = response.rates[targetCurrency.code]
                    else {
                        print("could not get rates for conversion")
                        return
                    }
                  
                    let conversionRate = targetRate / sourceRate
                    let convertedValue = conversionRate * value
                    
                    let finalResult = convertedValue as NSNumber
                    
                   let formattedValue = NumberFormatter()
                    
                    formattedValue.usesGroupingSeparator = true
                    formattedValue.groupingSeparator = " "
                    formattedValue.groupingSize = 3
                    formattedValue.numberStyle = .decimal
                    formattedValue.minimumFractionDigits = 2
                    formattedValue.maximumFractionDigits = 2
                    
                    let formattedResult = formattedValue.string(from: finalResult)
                    
                    
                    self?.convertedValueLabel.text = formattedResult?.description
                    
                  
                    
                case .failure(let error):
                    self?.alertManager.presentAlert(from: self!, message: error.localizedDescription)
                }
                self?.currencyActivityIndicator.stopAnimating()
            }
            
        }
    }
    
    
    private func getConvertValueWithRateURL() -> URL? {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "http"
        urlComponents.host = "data.fixer.io"
        urlComponents.path = "/api/latest"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_key", value: "3d2ba3bcfe5a29250698c07e1ac37680")
        ]
        
        return urlComponents.url
    }
    
}
