import UIKit

class TranslateViewController: BaseViewController {
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
    // MARK: Methods - Internal
    
    @IBAction private func didTapTranslateButton() {
        translateText()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Translate"
        translateActivityIndicator.hidesWhenStopped = true
        roundTextViews()
        roundButtons()
        settingUpToolBar()
    }
    
    // MARK: - Private
    
    // MARK: Properties - Private
    @IBOutlet private weak var topButton: UIButton!
    @IBOutlet weak var topTextView: UITextView!
    
    @IBOutlet private weak var translateButton: UIButton!
    @IBOutlet private weak var translateActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet private weak var bottomButton: UIButton!
    @IBOutlet private weak var bottomTextView: UITextView!
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        if let languageViewController = segue.destination as? LanguageViewController {
            languageViewController.delegate = self
            
            languageViewController.languageSelectionType = segue.identifier == "sourceLanguageSegue" ? .source : .target
            
            
            
        }
    }
    
    
    // MARK: Methods - Private
    
    
    private func roundTextViews() {
        bottomTextView.layer.cornerRadius = 10
        topTextView.layer.cornerRadius = 10
    }
    
    private func roundButtons() {
        topButton.layer.cornerRadius = 15
        bottomButton.layer.cornerRadius = 15
        translateButton.layer.cornerRadius = 20
    }
    
    private func settingUpToolBar() {
        let bar = UIToolbar()
        let reset = UIBarButtonItem(title: "Translate", style: .plain, target: self, action: #selector(didTapOnTranslateToolBarButton))
        bar.items = [.flexibleSpace(), reset]
        bar.sizeToFit()
        
        topTextView.inputAccessoryView = bar
    }
    
    private var textInputSearchString: String? {
        guard let textValue = topTextView.text else {
            return nil }
        return String(textValue)
    }
    
    
    private let networkManager = NetworkManager()
    
    @objc private func didTapOnTranslateToolBarButton() {
        view.endEditing(true)
        translateText()
    }
    
    
    
    private var sourceLanguage: Language = .french {
        didSet {
            topButton.setTitle(sourceLanguage.title.uppercased(), for: .normal)
        }
    }
    private var targetLanauge: Language = .english {
        didSet {
            bottomButton.setTitle(targetLanauge.title.uppercased(), for: .normal)
        }
    }
    
    
    
    private func translateText() {
        
        translateActivityIndicator.startAnimating()
        
        guard let textInput = textInputSearchString else {
            
            return
        }
        
        
        guard let url = getTranslateURL(sourceLanguageCode: sourceLanguage.code, targetLanguageCode: targetLanauge.code, textToTranslate: textInput) else {
            print("Could not create URL for translate text")
            return
        }
        
        networkManager.fetch(url: url) { [weak self] (result: Result<TranslateResponse, NetworkManagerError>) in
            DispatchQueue.main.async {
                self?.translateActivityIndicator.stopAnimating()
                
                switch result {
                case .success(let response):
                    
                    self?.bottomTextView.text = response.data?.translations?.first?.translatedText
                    
                    
                case .failure( _):
                    self?.alertManager.presentAlert(from: self!, message: "Could not get data for translate text")
                }
            }
            
        }
    }
    
    
    private func getTranslateURL(sourceLanguageCode: String, targetLanguageCode: String, textToTranslate: String) -> URL? {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "translation.googleapis.com"
        urlComponents.path = "/language/translate/v2"
        urlComponents.queryItems = [
            .init(name: "q", value: textToTranslate),
            .init(name: "source", value: sourceLanguageCode),
            .init(name: "target", value: targetLanguageCode),
            .init(name: "format", value: "text"),
            .init(name: "key", value: "AIzaSyDtmMVvnki4g7JWBLlZ7rR2HgqJCsRD534")
        ]
        
        return urlComponents.url
    }
    
    
    
}



extension TranslateViewController: LanguageViewControllerDelegate {
    func didSelectLanguage(language: Language, languageSelectionType: LanguageSelectionType) {
        
        switch languageSelectionType {
        case .source: sourceLanguage = language
        case .target: targetLanauge = language
        }
        
    }
}

enum LanguageSelectionType {
    case source
    case target
}

