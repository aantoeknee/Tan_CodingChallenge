//
//  TrackResponse.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/7/20.
//

import Foundation

struct TrackResponse: Decodable {
  
  // MARK: - Properties
  
   var resultCount: Int
   var results: [Track]
}
