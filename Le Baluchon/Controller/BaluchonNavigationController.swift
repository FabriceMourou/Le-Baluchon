import UIKit


class BaluchonNavigationController: UINavigationController {
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
    // MARK: Methods - Internal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.prefersLargeTitles = true
        
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        setFont()
        
        
        navigationBar.largeTitleTextAttributes = textAttributes
    }
    
    // MARK: - Private
    
    // MARK: Properties - Private
    
    // MARK: Methods - Private
    
    
    private func setFont()
    {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Avenir", size: 20)!]
    }
}
