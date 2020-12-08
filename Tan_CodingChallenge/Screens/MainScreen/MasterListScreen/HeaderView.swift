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
    let lastAcitivity = LastVisited().getLastTrack()?.dateTime
    
    if lastAcitivity != nil {
      self.dateLabel.text = "Last activity was on \(LastVisited().getLastTrack()?.dateTime ?? "")"
    } else {
      self.dateLabel.text = "No recent activity"
    }
  }
}
