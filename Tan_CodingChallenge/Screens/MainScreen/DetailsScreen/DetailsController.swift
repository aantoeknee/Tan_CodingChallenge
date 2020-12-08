//
//  DetailsController.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/8/20.
//

import AVKit
import Kingfisher
import UIKit

class DetailsController: UIViewController {
  
  @IBOutlet weak var playerView: UIView!
  @IBOutlet weak var openSafariStack: UIStackView!
  @IBOutlet weak var artwork: UIImageView!
  @IBOutlet weak var previewButton: UIButton!
  
  @IBOutlet weak var trackName: UILabel!
  @IBOutlet weak var trackGenre: UILabel!
  @IBOutlet weak var trackPrice: UILabel!
  @IBOutlet weak var trackDescription: UILabel!
  @IBOutlet weak var noPreviewL: UILabel!
  
  var viewModel: DetailsViewModel? = nil
  var previewUrl: String? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initViews()
  }
  
  private func initViews() {
    self.trackName.text = viewModel?.name
    self.trackGenre.text = viewModel?.genre
    self.trackPrice.text = viewModel?.price
    self.trackDescription.text = viewModel?.description
    
    // Load thumbnail
    let artworkUrl = viewModel?.artWorkUrl
    let urlRequest = URL(string: artworkUrl!)
    self.artwork.kf.setImage(with: urlRequest)
    
    // Determine if previewUrl is empty to hide preview button
    let previewUrl = viewModel?.previewUrl
    if previewUrl == nil {
      previewButton.isHidden = true
      noPreviewL.isHidden = false
    } else {
      previewButton.isHidden = false
      noPreviewL.isHidden = true
      self.previewUrl = previewUrl
    }
  }
  
  @IBAction func previewClicked(_ sender: Any) {
    // Open Media Player
    guard let previewUrl = self.previewUrl else { return }
    let url = URL(string: previewUrl)
    let player = AVPlayer(url: url!)
    let playerController = AVPlayerViewController()
    playerController.player = player
    self.navigationController?.pushViewController(playerController, animated: true)
    player.play()
  }
}
