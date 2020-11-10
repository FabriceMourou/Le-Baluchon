import UIKit

class TranslateViewController: BaseViewController{
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
    // MARK: Methods - Internal
    
    @IBAction func tapTranslateButton() {
        guard let textInput = textInputSearchString else {
            print("Could not get text from textfield")
            return
        }
        
        translateText(textToTranslate: textInput)
        
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Translate"
        
        roundTextViews()
        roundButtons()
    }
    
    // MARK: - Private
    
    // MARK: Properties - Private
    @IBOutlet private weak var topButton: UIButton!
    @IBOutlet private weak var topTextField: UITextField!
    
    @IBOutlet private weak var translateButton: UIButton!
    
    @IBOutlet private weak var bottomButton: UIButton!
    @IBOutlet private weak var bottomTextView: UITextView!
    
    
    
    // MARK: Methods - Private
    
    
    private func roundTextViews() {
        bottomTextView.layer.cornerRadius = 5
    }
    
    private func roundButtons() {
        topButton.layer.cornerRadius = 15
        bottomButton.layer.cornerRadius = 15
        translateButton.layer.cornerRadius = 20
    }
    
   
    
    private var textInputSearchString: String? {
        guard let textValue = topTextField.text else {
            return nil }
        return String(textValue)
    }
    
    
    private let networkManager = NetworkManager()
    
    private func translateText(textToTranslate: String)  {
        
        
        guard let url = getTranslateURL(textToTranslate: textToTranslate) else {
            print("Could not create URL for translate text")
            return
        }
        
        networkManager.fetch(url: url) { (result:
            Result<Language, NetworkManagerError>) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("coucou!!!")
                   
                    self.bottomTextView.text = response.language
                    
                   
                    
                    
                case .failure:
                    print("failure")
                }
            }
            
        }
    }
    private var language: Language?
    
    
    private func getTranslateURL(textToTranslate: String) -> URL? {
        
        var urlComponents = URLComponents()
    
        urlComponents.scheme = "https"
        urlComponents.host = "translation.googleapis.com"
        urlComponents.path = "/language/translate/v2"
        urlComponents.queryItems = [
            .init(name: "q", value: textToTranslate),
            .init(name: "source", value: "fr"),
            .init(name: "target", value: "en"),
            .init(name: "format", value: "text"),
            .init(name: "key", value: "AIzaSyDtmMVvnki4g7JWBLlZ7rR2HgqJCsRD534")
        ]
        
        return urlComponents.url
    }
    
    
    
}
