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

  func getTracks(completion: @escaping (_ tracks: [Track]) -> ()) {
    AF.request(url, method: .get).responseJSON { response in
      switch response.result {
      case .success:
        let decoder = JSONDecoder()
        
        do {
          let model = try decoder.decode(TrackResponse.self, from: response.data!)
          let tracks = model.results
          self.track.deleteAll()
          self.track.saveAll(tracks: tracks)
          completion(self.track.queryAll())
        }
        catch {
          print("Error: \(error)")
          completion(self.track.queryAll())
    
        }
      case .failure:
        print("Failed retrieving data")
        completion(self.track.queryAll())
  
      }
    }
  }
}
