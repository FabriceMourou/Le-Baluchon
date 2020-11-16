
import UIKit

class LanguageViewController: UIViewController {
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    var language: [Languages] = []
    
    
    @IBOutlet weak var languageTableView: UITableView!
    
    
    // MARK: Methods - Internal
    
    /// ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        language = createArray()
    }
    
    // MARK: - Private
    
    // MARK: Properties - Private
    
    
    
    
    // MARK: Methods - Private
    func createArray() -> [Languages] {
        
        var allLanguages: [Languages] = []
        
        let language1 = Languages(image: #imageLiteral(resourceName: "Dutch-Flag") , title: "Dutch")
        let language2 = Languages(image: #imageLiteral(resourceName: "English-Flag"), title: "English")
        let language3 = Languages(image: #imageLiteral(resourceName: "French-Flag"), title: "French")
        let language4 = Languages(image: #imageLiteral(resourceName: "German-Flag"), title: "German")
        let language5 = Languages(image: #imageLiteral(resourceName: "Portugese-Flag"), title: "Portugese")
        let language6 = Languages(image: #imageLiteral(resourceName: "Spanish-Flag"), title: "Spanish")
        
        allLanguages.append(language1)
        allLanguages.append(language2)
        allLanguages.append(language3)
        allLanguages.append(language4)
        allLanguages.append(language5)
        allLanguages.append(language6)
        
        return allLanguages
    }
    
    
    @IBAction private func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension LanguageViewController: UITableViewDataSource, UITabBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return language.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let languages = language[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell") as! LanguageTableViewCell
        
        cell.setLanguage(languages: languages)
        
        return cell
    }
    
    
    
    
    
}






