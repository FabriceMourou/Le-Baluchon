import UIKit





class AlertManager {
    
    func presentAlert(from viewController: UIViewController, message: String) {
        
        let alertController = UIAlertController(title: "🚫-ERROR-🚫",
                                                message: message,
                                                preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Done",
                                       style: .default,
                                       handler: nil)
        okayAction.setValue(UIColor.darkGray, forKey: "titleTextColor")
        
        
        alertController.addAction(okayAction)
        
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
}


