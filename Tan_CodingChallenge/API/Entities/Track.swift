//
//  Track.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/7/20.
//

import Foundation
import RealmSwift


class Track: Object, Decodable {
  
  // MARK: - Properties
  
  @objc dynamic var wrapperType = ""
  @objc dynamic var kind: String? = nil
  @objc dynamic var name: String? = nil
  @objc dynamic var collectionName: String? = nil
  @objc dynamic var artworkUrl: String? = nil
  @objc dynamic var genre = ""
  @objc dynamic var price: Double = 0.0
  @objc dynamic var shortDesc: String? = nil
  @objc dynamic var longDesc: String? = nil
  @objc dynamic var desc: String? = nil
  @objc dynamic var previewUrl: String? = nil
  
  // MARK: - Coding Keys
  
  private enum CodingKeys: String, CodingKey {
    
    case wrapperType
    case kind
    case name = "trackName"
    case collectionName
    case artworkUrl = "artworkUrl100"
    case genre = "primaryGenreName"
    case price = "collectionPrice"
    case shortDesc = "shortDescription"
    case longDesc = "longDescription"
    case desc = "description"
    case previewUrl
  }
}

// MARK: Realm Functions

extension Track {
  
  // Save all tracks retrieved from the API consumption
  
  public func saveAll(tracks: [Track]) {
    let realm = try! Realm()
    for track in tracks {
      try! realm.write {
          realm.add(track)
      }
    }
  }
  
  // Queary All tracks and pass it to the caller
  
  public func queryAll() -> [Track] {
    let realm = try! Realm()
    let tracks = Array(realm.objects(Track.self))
    return tracks
  }
  
  // Delete all Tracks
  
  public func deleteAll() {
    do {
      let realm = try Realm()
      try realm.write {
        let tracks = realm.objects(Track.self)
        realm.delete(tracks)
      }
    } catch {
      print(error)
    }
  }
}
