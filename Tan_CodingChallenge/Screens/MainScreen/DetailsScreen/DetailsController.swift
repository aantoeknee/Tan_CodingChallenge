//
//  DetailsController.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/8/20.
//

import AVKit
import Kingfisher
import UIKit

// MARK:- Enums for WrapperType
enum WrapperType: String {
  
  case track = "track"
  case audioBook = "audioBook"
}
// MARK:- Enums for TrackKind
enum TrackKind: String {
  
  case song = "song"
  case movie = "feature-movie"
  case series = "tv-episode"
}

class DetailsController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var playerView: UIView!
  @IBOutlet weak var artwork: UIImageView!
  @IBOutlet weak var previewButton: UIButton!
  @IBOutlet weak var trackName: UILabel!
  @IBOutlet weak var trackGenre: UILabel!
  @IBOutlet weak var trackPrice: UILabel!
  @IBOutlet weak var trackDescription: UILabel!
  @IBOutlet weak var noPreviewL: UILabel!
  @IBOutlet weak var wrapKindL: UILabel!
  
  
  // MARK: - Properties
  
  var viewModel: DetailsViewModel? = nil
  var previewUrl: String? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  // MARK: - Initialize Views
  
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
    
    // Determine WrapType
    guard let wrapper = viewModel?.wrapperType else { return }
    guard let wrapperType = WrapperType(rawValue: wrapper) else { return }
    
    switch wrapperType {
    case .track:
      guard let kind = viewModel?.kind else { return }
      guard let trackKind = TrackKind(rawValue: kind) else { return }
      let wrapType = WrapperType.track.rawValue
      
      // Determine what kind of Track
      switch trackKind {
      case .song:
        let trackKind = TrackKind.song.rawValue
        self.wrapKindL.text = "\(wrapType)(\(trackKind))"
      case .movie:
        let trackKind = TrackKind.movie.rawValue
        self.wrapKindL.text = "\(wrapType)(\(trackKind))"
      case .series:
        let trackKind = TrackKind.series.rawValue
        self.wrapKindL.text = "\(wrapType)(\(trackKind))"
        break
      }
      
    case .audioBook:
      self.wrapKindL.text = WrapperType.audioBook.rawValue
    }
  }
  // MARK: - Preview Button Clicked
  
  @IBAction func previewClicked(_ sender: Any) {
    
    networkAvailability() // Check internet connection
    guard let previewUrl = self.previewUrl else { return }
    let url = URL(string: previewUrl)
    
    let player = AVPlayer(url: url!)
    let playerController = AVPlayerViewController()
    playerController.player = player
    
    self.navigationController?.pushViewController(playerController, animated: true)
    
    // Start playing the video/audio
    player.play()
    
  }
}
  
