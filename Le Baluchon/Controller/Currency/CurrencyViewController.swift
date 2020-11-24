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
    @IBOutlet weak var convertedValueLabel: UILabel!
    @IBOutlet private weak var sourceCurrencySymbolLabel: UILabel!
    @IBOutlet private weak var targetCurrencySymbolLabel: UILabel!
    @IBOutlet private weak var swapCurrenciesButton: UIButton!
    @IBOutlet weak var currencyActivityIndicator: UIActivityIndicatorView!
    
    
    
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
    
    private let currencyManager = CurrencyManager()
    
    private func convert() {
        guard let valueToConvert = valueToConvert else {
            alertManager.presentAlert(from: self, message: "Could not get value to convert")
            return
        }
        currencyActivityIndicator.startAnimating()
        currencyManager.convertValueWithRate(value: valueToConvert, sourceCurrency: sourceCurrency, targetCurrency: targetCurrency) { [weak self] result in
            DispatchQueue.main.async {
                self?.currencyActivityIndicator.stopAnimating()
                
                switch result {
                case .failure(let error):
                    self?.alertManager.presentAlert(from: self!, message: error.localizedDescription)
                case .success(let convertedValue):
                    self?.convertedValueLabel.text = convertedValue
                }
            }
            
        }
        
    }
    
    
   
    
}

