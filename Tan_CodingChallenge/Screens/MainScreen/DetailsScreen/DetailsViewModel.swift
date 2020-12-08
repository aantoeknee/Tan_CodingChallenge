//
//  DetailsViewModel.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/8/20.
//

import Foundation

public class DetailsViewModel {
  
  // MARK: - Properties
  
  var track: Track? = nil
  
  var wrapperType: String {
    return track?.wrapperType ?? ""
  }
  
  var kind: String? {
    return track?.kind ?? ""
  }
  
  var name: String? {
    // If trackName is empty, returns collectionName
    return track?.name == nil ?
      track?.collectionName :
      track?.name
  }
  
  var artWorkUrl: String {
    return track?.artworkUrl ?? ""
  }
  
  var genre: String {
    return track?.genre ?? ""
  }
  
  var price: String {
    return "$ \(track?.price ?? 0.0)"
  }
  
  var previewUrl: String {
    return track?.previewUrl ?? ""
  }
  
  var description: String {
    let longDesc = track?.longDesc
    let shortDesc = track?.longDesc
    let desc = track?.desc
    
    if longDesc != nil {
      return longDesc ?? ""
    } else if shortDesc != nil {
      return shortDesc ?? "" // If long description is empty, returns short description
    } else {
      return desc ?? "No description available" // If long short is empty returns description
    }
  }
  
  // MARK: - Initializer
  
  init(track: Track) {
    self.track = track
  }
}
