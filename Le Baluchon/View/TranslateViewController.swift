import UIKit

class TranslateViewController: BaseViewController{
    
    // MARK: - Internal
    
    // MARK: Properties - Internal
    
    // MARK: Methods - Internal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Translate"
        
        roundTextViews()
        roundButtons()
    }
    
    // MARK: - Private
    
    // MARK: Properties - Private
    
    @IBOutlet private weak var topTextView: UITextView!
    @IBOutlet private weak var bottomTextView: UITextView!
    @IBOutlet private weak var bottomButton: UIButton!
    @IBOutlet private weak var topButton: UIButton!
    @IBOutlet private weak var playButton: UIButton!
    
    // MARK: Methods - Private
    
    private func roundTextViews() {
        topTextView.layer.cornerRadius = 10
        bottomTextView.layer.cornerRadius = 10
    }
    
    private func roundButtons() {
        topButton.layer.cornerRadius = 15
        bottomButton.layer.cornerRadius = 15
        playButton.layer.cornerRadius = 20
    }
    
}
