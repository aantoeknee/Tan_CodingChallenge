//
//  TrackService.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/7/20.
//

import Alamofire
import Foundation

public class TrackService {
  
  let url = "https://itunes.apple.com/search?term=star&amp;country=au&amp;media=movie&amp;all"
  let track = Track()
  
  // MARK: - GET Data from API
  
  func getTracks(completion: @escaping (_ tracks: [Track]) -> ()) {
    AF.request(url, method: .get).responseJSON { response in
      
      switch response.result {
      case .success:
        let decoder = JSONDecoder()
        
        do {
          let model = try decoder.decode(TrackResponse.self, from: response.data!)
          let tracks = model.results
          
          // Delete previous data to avoid duplication
          
          self.track.deleteAll()
          
          // Save newly retrieved data
          
          self.track.saveAll(tracks: tracks)
          
          // Return all queried data
          
          completion(self.track.queryAll())
        }
        catch {
          print("Error: \(error)")
          
          // Return all quiried data
          
          completion(self.track.queryAll())
    
        }
      case .failure:
        // If unable to retrieve data
        print("Failed retrieving data")
        completion(self.track.queryAll())
  
      }
    }
  }
}
