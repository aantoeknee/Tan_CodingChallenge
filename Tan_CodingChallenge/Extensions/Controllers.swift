//
//  Controllers.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/9/20.
//

import Foundation
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
}

// MARK: - Check Network Availability

extension UIViewController {
  
  func networkAvailability() {
    if !Reachability.isConnectedToNetwork() {
      self.showSnackBar(message: "No Internet connection.")
    }
  }
}
