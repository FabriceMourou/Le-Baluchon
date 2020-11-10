
import UIKit

class LanguageViewController: UIViewController
                           ,UIPickerViewDelegate
                           ,UIPickerViewDataSource
{
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
    // MARK: Methods - Internal
    
    func selectedLanguage() {
        let languageIndex = languagePickerView.selectedRow(inComponent: 0)
        let languageSelected = languagesList[languageIndex]
    }
    
    /// ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        goButton.layer.cornerRadius = 50
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  languagesList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  languagesList[row]

    }
    
    // MARK: - Private
    
    // MARK: Properties - Private
    
    @IBOutlet private weak var goButton: UIButton!
    @IBOutlet private weak var languagePickerView: UIPickerView!
    
    
    // MARK: Methods - Private
    
    
    
    @IBAction private func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
