//
//  Controllers.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/9/20.
//

import Foundation
import Reachability
import SystemConfiguration
import TTGSnackbar
import UIKit


// MARK: - Snackbar Functions
extension UIViewController {
  
  func showSnackBar(message: String) {
    let snackBar = TTGSnackbar(message: message, duration: .middle)
    snackBar.backgroundColor = .black
    snackBar.show()
  }
  
  func showSnackBarWithAction(message: String) {
    let snackbar = TTGSnackbar(
        message: message,
        duration: .long,
        actionText: "Okay",
        actionBlock: { (snackbar) in
          snackbar.isHidden = true
        }
    )
    snackbar.show()
  }
}

// MARK: - Check Network Availability

extension UIViewController {
  
  func networkAvailability() {
    if !Reachability.isConnectedToNetwork() {
      self.showSnackBar(message: "No internet connection")
    }
  }
}
