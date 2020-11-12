import UIKit

class TranslateViewController: BaseViewController {
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
    // MARK: Methods - Internal
    
    @IBAction private func tapTranslateButton() {

        translateText()
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Translate"
        
        roundTextViews()
        roundButtons()
        settingUpToolBar()
    }
    
    // MARK: - Private
    
    // MARK: Properties - Private
    @IBOutlet private weak var topButton: UIButton!
    @IBOutlet weak var topTextView: UITextView!
    
    
    @IBOutlet private weak var translateButton: UIButton!
    
    @IBOutlet private weak var bottomButton: UIButton!
    @IBOutlet private weak var bottomTextView: UITextView!
    
    
    
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
    
    private func translateText() {
        
        guard let textInput = textInputSearchString else {
            print("Could not get text from textfield")
            return
        }
        
        
        guard let url = getTranslateURL(textToTranslate: textInput) else {
            print("Could not create URL for translate text")
            return
        }
        
        networkManager.fetch(url: url) { (result:
            Result<TranslateResponse, NetworkManagerError>) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("coucou!!!")
                   
                    self.bottomTextView.text = response.data?.translations?.first?.translatedText
                    
                   
                    
                    
                case .failure:
                    print("failure")
                }
            }
            
        }
    }
    
    
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
