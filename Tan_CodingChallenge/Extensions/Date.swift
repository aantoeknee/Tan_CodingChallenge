//
//  Date.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/8/20.
//

import Foundation

extension Date {
  
  // MARK - Convert Date object to String
  
  func toString(format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    
    return dateFormatter.string(from: self)
  }
}
