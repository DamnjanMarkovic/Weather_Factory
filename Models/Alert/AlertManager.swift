//
//  AlertManager.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 7.12.21..
//

import Foundation
import UIKit
class AlertManager{
   
  static var shareinstance = AlertManager()
    
    func showAlert(on VC:UIViewController,alertmessageTitle:String,alertmessageContent:String){
        
        let alertController = UIAlertController(title: alertmessageTitle, message: alertmessageContent, preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(alertOkAction)
        VC.present(alertController, animated: true, completion: nil)
        
    }
    
}
