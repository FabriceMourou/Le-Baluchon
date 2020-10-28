import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
    // MARK: Methods - Internal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let closingKeyboardGestureRecogniyer = UITapGestureRecognizer(
            target: self,
            action: #selector(closeKeyboard)
        )
        
        view.addGestureRecognizer(closingKeyboardGestureRecogniyer)
        
    }
    
    // MARK: - Private
    
    // MARK: Properties - Private
    
    // MARK: Methods - Private
    
    @objc private func closeKeyboard() {
        view.endEditing(true)
    }
    
    
}
