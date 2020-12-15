//
//  File.swift
//  
//
//  Created by Cristian Carlassare on 27/11/2020.
//

import UIKit


public extension UIViewController {

    func showAlert(title: String, message : String, okButtonText: String) {
        let alertController = UIAlertController(title: title.localized, message: message.localized, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: okButtonText.localized, style: .default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message : String, okButtonText: String, cancelButtonText: String, OKActionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: title.localized, message: message.localized, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: okButtonText.localized, style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
            OKActionHandler()
        }

        let cancelAction = UIAlertAction(title: cancelButtonText.localized, style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }

        alertController.addAction(OKAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

