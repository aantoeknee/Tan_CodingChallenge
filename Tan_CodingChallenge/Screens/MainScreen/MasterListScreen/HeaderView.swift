//
//  HeaderView.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/8/20.
//

import Foundation
import UIKit

class HeaderView: UICollectionReusableView {
  
  @IBOutlet weak var dateLabel: UILabel!
  
  static let cellIdentifier = String(describing: HeaderView.self)
  
  override func prepareForReuse() {
    let date = AppPreferences.getDate()
    
    if date != nil {
      self.dateLabel.text = "You recently visited on \(date ?? "")"
    } else {
      self.dateLabel.text = "No recent views"
    }
  }
}
