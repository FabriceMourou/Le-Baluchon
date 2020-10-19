
import UIKit

class CityViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
     
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var hightLowLabel: UILabel!
    
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
