import UIKit





class AlertManager {
    
    func presentAlert(from viewController: UIViewController, message: String) {
        
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
        
        alertController.addAction(okayAction)
        
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
}


