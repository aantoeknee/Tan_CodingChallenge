//
//  AppPreferences.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/8/20.
//

import Foundation

class AppPreferences {
  
  private static let dateActive = "dateActive"
  
  static func saveDate() {
    let date = Date().toString(format: "MMM d, h:mm a")
    UserDefaults.standard.set(date, forKey: dateActive)
  }
  
  static func getDate() -> String? {
    return UserDefaults.standard.string(forKey: dateActive)
  }
}
