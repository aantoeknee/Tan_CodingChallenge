//
//  LastVisited.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/8/20.
//

import Foundation
import RealmSwift

class LastVisited: Object, Decodable {
  
  @objc dynamic var dateTime = ""
  @objc dynamic var track: Track?
}

// MARK:
extension LastVisited {
  
  public func saveTrack(track: Track, date: String) {
    // Create LastVisitedTrack Object
    
    let lastVisitedTrack = LastVisited()
    lastVisitedTrack.dateTime = date
//    lastVisitedTrack.track = track
    
    // Delete recent Saved object
    deleteAll()
    //Save the object to Realm
    do {
      let realm = try Realm()
      try realm.write {
        realm.add(lastVisitedTrack)
      }
    } catch {
      print(error)
    }
  }
  
  public func deleteAll() {
    do {
      let realm = try Realm()
      try realm.write {
        let tracks = realm.objects(LastVisited.self)
        realm.delete(tracks)
      }
    } catch {
      print(error)
    }
  }
  
  public func getLastTrack() -> LastVisited? {
    var lastVisited: [LastVisited] = []
    do {
      let realm = try Realm()
      lastVisited = Array(realm.objects(LastVisited.self))
    } catch {
      print(error)
    }
    return lastVisited.first
  }
}
