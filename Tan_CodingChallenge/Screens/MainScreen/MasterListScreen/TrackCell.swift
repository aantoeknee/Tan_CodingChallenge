//
//  TrackCell.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/7/20.
//

import Kingfisher
import UIKit

class TrackCell: UICollectionViewCell {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var trackName: UILabel!
  @IBOutlet weak var artwork: UIImageView!
  @IBOutlet weak var trackGenre: UILabel!
  @IBOutlet weak var price: UILabel!
  
  var cellViewModel: TrackCellViewModel? = nil
  
  // CellIdentifier for Initializing CollectionView
  static let cellIdentifier = String(describing: TrackCell.self)
    
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - Initializer for cells
  
  func setupCell(cellViewModel: TrackCellViewModel?) {
    
    self.cellViewModel = cellViewModel
    self.trackName.text = self.cellViewModel?.name
    self.trackGenre.text = self.cellViewModel?.genre
    self.price.text = self.cellViewModel?.price
    
    // For rendering image
    guard let imageUrl = self.cellViewModel?.artworkUrl else { return }
    let urlRequest = URL(string: imageUrl)
    self.artwork.kf.indicatorType = .activity
    self.artwork.kf.setImage(with: urlRequest)
  }
}
