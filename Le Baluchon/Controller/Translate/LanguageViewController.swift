
import UIKit


protocol LanguageViewControllerDelegate: class {
    func didSelectLanguage(language: Language, languageSelectionType: LanguageSelectionType)
}

class LanguageViewController: UIViewController {
    
    
    var languageSelectionType: LanguageSelectionType?
    weak var delegate: LanguageViewControllerDelegate?
    
    // MARK: - Internal
    
    // MARK: Properties - Internal

    
    
    @IBOutlet weak var languageTableView: UITableView!
    
    
    // MARK: Methods - Internal
    
    
    // MARK: - Private
    
    // MARK: Properties - Private
    
    
    
    
    
    @IBAction private func dismiss() {
        dismiss(animated: true, completion: nil)
        
    }
    
    
}

extension LanguageViewController: UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Language.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let language = Language.allCases[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell") as! LanguageTableViewCell
        
        cell.setLanguage(languages: language)
        
        return cell
    }
    
    
    
    
    
}


extension LanguageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLanguage = Language.allCases[indexPath.row]
        guard let languageSelectionType = languageSelectionType else { return }
        delegate?.didSelectLanguage(language: selectedLanguage, languageSelectionType: languageSelectionType)
        dismiss(animated: true, completion: nil)
    }
}




