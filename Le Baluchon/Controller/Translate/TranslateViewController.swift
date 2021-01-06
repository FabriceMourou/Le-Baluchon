import UIKit

class TranslateViewController: BaseViewController {
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
    // MARK: Methods - Internal
    
    @IBAction private func didTapTranslateButton() {
        translate()
        
    }
    
    
    private func translate() {
        translateActivityIndicator.startAnimating()
        translateManager.translateText(
            text: topTextView.text,
            sourceLanguage: sourceLanguage,
            targetLanguage: targetLanguage
        ) { [weak self] (result) in
            
            DispatchQueue.main.async {
                self?.translateActivityIndicator.stopAnimating()
                
                switch result {
                case .failure(let error):
                    self?.presentAlert()
                case .success(let translatedText):
                    self?.bottomTextView.text = translatedText
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
    
    let translateManager = TranslateManager()
    
    
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
    @IBOutlet private weak var topTextView: UITextView!
    
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
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil
        )
        
        bar.items = [flexibleSpace, reset]
        bar.sizeToFit()
        
        topTextView.inputAccessoryView = bar
    }
    
    
    
    @objc private func didTapOnTranslateToolBarButton() {
        view.endEditing(true)
        translate()
    }
    
     var sourceLanguage: Language = .french {
        didSet {
            topButton.setTitle(sourceLanguage.title.uppercased(), for: .normal)
        }
    }
     var targetLanguage: Language = .english {
        didSet {
            bottomButton.setTitle(targetLanguage.title.uppercased(), for: .normal)
        }
    }
    
    
    
 
    
    
    
}

extension TranslateViewController: LanguageViewControllerDelegate {
    func didSelectLanguage(language: Language, languageSelectionType: LanguageSelectionType) {
        
        switch languageSelectionType {
        case .source: sourceLanguage = language
        case .target: targetLanguage = language
        }
        
    }
}

enum LanguageSelectionType {
    case source
    case target
}

