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
  
  func getTracks(_ controller: UIViewController, completion: @escaping (_ tracks: [Track], _ error: NSError?) -> ()) {

    if Reachability.isConnectedToNetwork() {
      AF.request(url, method: .get, requestModifier: { $0.timeoutInterval = 30 }).responseJSON { response in
        switch response.result {
        case .success:
          let decoder = JSONDecoder()
          do {
            let model = try decoder.decode(TrackResponse.self, from: response.data!)
            let tracks = model.results
            
            self.track.deleteAll()// Delete previous data to avoid duplication
            self.track.saveAll(tracks: tracks)// Save newly retrieved data
            completion(self.track.queryAll(), nil)// Return all queried data
          }
          catch {
            // Return all queried data
            let nserror = error as NSError
            completion(self.track.queryAll(), nserror)
      
          }
        case .failure(let err):
          // If unable to retrieve data, fetch data from database
          let nserror = err as NSError
          completion(self.track.queryAll(), nserror)
    
        }
      }
    }
    else {
      controller.networkAvailability()
      completion(self.track.queryAll(), nil)
    }
  }
}
