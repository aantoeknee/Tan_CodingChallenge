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
  
  @objc dynamic var id = 0
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
  @objc dynamic var isFavorite: Bool = false
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
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
  
  func IncrementaID() -> Int{
      let realm = try! Realm()
      if let retNext = realm.objects(Track.self).sorted(byKeyPath: "id").last?.id {
          return retNext + 1
      }else{
          return 1
      }
  }
  
  // Save all tracks retrieved from the API consumption
  
  public func saveAll(tracks: [Track]) {
    let currentTracks = queryAll()
    
    if currentTracks.isEmpty {
      for track in tracks {
        let realm = try! Realm()
        track.id = track.IncrementaID()
        try! realm.write {
          realm.add(track, update: .all)
        }
      }
    }
    else {
      var newTracks: [Track] = []
      var counter = 0
      for track in tracks {
        for currentTrack in currentTracks {
          if currentTrack.collectionName == track.collectionName {
            counter += 1
          }
          if counter == 0 {
            newTracks.append(track)
          }
        }
      }
      for track in newTracks {
        let realm = try! Realm()
        track.id = track.IncrementaID()
        do {
          try realm.write {
            realm.add(track)
          }
        } catch {
          print(error)
        }
      }
    }
  }
  
  // Queary All tracks and pass it to the caller
  
  public func queryAll() -> [Track] {
    let realm = try! Realm()
    let tracks = Array(realm.objects(Track.self))
    return tracks
  }
  
  // Query All favorite tracks
  
  public func queryAllFavorites() -> [Track] {
    do {
      let realm = try Realm()
      let tracks = Array(realm.objects(Track.self).filter("isFavorite = true"))
      return tracks
    } catch {
      print(error)
      return []
    }
  }
  
  public func getTrack(id: Int) -> Track? {
    do {
      let realm = try Realm()
      let track = realm.object(ofType: Track.self, forPrimaryKey: id)
      return track
    } catch {
      print(error)
      return nil
    }
  }
  // Update a track
  
  public func updateTrack(_ track: Track) {
    do {
      let realm = try Realm()
      try realm.write {
        track.isFavorite = track.isFavorite ? false : true
      }
    } catch {
      print(error)
    }
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
