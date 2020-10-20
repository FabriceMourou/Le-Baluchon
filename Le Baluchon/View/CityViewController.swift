
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
    
    
    private let networkManager = NetworkManager()
    
//    private func getCurrencyData() {
//        networkManager.fetch(url: URL(string: "http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=022b0764cc4f75219db52fb5bb71cd2b")!) { (result: Result<MeteoResponse, NetworkManagerError>) in
//
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let response):
//                    print("Success")
//
//                    let cityName = response.city["name"]!
//
//                    print(cityName)
//
//                    self.cityLabel.text = cityName.description
//                case .failure:
//                    print("failure")
//                }
//            }
//
//        }
//    }
    
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
