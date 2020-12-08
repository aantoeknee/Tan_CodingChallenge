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
  
  // CellIdentifier for Initializing HeaderView in CollectionView.
  static let cellIdentifier = String(describing: HeaderView.self)
  
  override func prepareForReuse() {
    setupView()
  }
  
  // MARK: - Initialize HeaderView with value.
  private func setupView() {
    let date = RecentDate().getDate() //Retrieve saved date in UserDefaults
    if date != nil && date != "" {
      self.dateLabel.text = "You recently visited on \(date ?? "")" // If saved date available
    } else {
      self.dateLabel.text = "No recent visit" // No saved date
    }
  }
}
