import UIKit

class BaluchonTabBarController: UITabBarController {
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
    // MARK: Methods - Internal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarItens()
        
    }
    
    // MARK: - Private
    
    // MARK: Properties - Private
    
    private let tabBarTitles: [String] = [
        "Currency",
        "Weather",
        "Translate"
    ]
    
    // MARK: Methods - Private
    
    private func setupTabBarItens() {
        
        
        guard
            let itens = tabBar.items
        else {
            print("Could not setup tab bar itens")
            return
        }
        
        
        for (index, iten) in itens.enumerated() where index < tabBarTitles.count {
            iten.title = tabBarTitles[index]
        }
        
    }
    
    
}
