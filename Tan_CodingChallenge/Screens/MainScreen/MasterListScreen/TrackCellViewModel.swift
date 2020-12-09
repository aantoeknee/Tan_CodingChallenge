//
//  TrackCellViewModel.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/7/20.
//

import Foundation

public class TrackCellViewModel {
  
  // MARK: - Properties
  
  var track: Track? = nil
  
  var name: String? {
    // If trackName is empty, returns collectionName
    return track?.name == nil ?
      track?.collectionName :
      track?.name
  }
  
  var artworkUrl: String {
    return track?.artworkUrl ?? ""
  }
  
  var genre: String {
    return track?.genre ?? ""
  }
  
  var price: String {
    return "$\(track?.price ?? 0.0)"
  }
  
  // MARK: - Initializer
  
  init(track: Track) {
    self.track = track
  }
}
