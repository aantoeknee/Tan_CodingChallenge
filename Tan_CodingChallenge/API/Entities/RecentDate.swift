//
//  RecentDate.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/9/20.
//

import Foundation
import RealmSwift

class RecentDate: Object {
  
  // MARK: - Properties
  
  @objc dynamic var date = ""
}

// MARK: - Realm Functions

extension RecentDate {
  
  // Save current date and time
  
  public func saveDate() {
    if Reachability.isConnectedToNetwork() {
      let date = Date().toString(format: "MMM d, h:mm a")
      let dateObject = RecentDate()
      dateObject.date = date
      
      deleteDate()
      do {
        let realm = try Realm()
          try realm.write {
              realm.add(dateObject)
          }
      } catch {
        print(error)
      }
    }
  }
  
  // Retrieve saved date
  
  public func getDate() -> String? {
    let realm = try! Realm()
    let dateObject = Array(realm.objects(RecentDate.self)).first
    let recentDate = dateObject?.date
    return recentDate ?? ""
  }
  
  // Delete date saved.
  
  public func deleteDate() {
    do {
      let realm = try Realm()
      try realm.write {
        let tracks = realm.objects(RecentDate.self)
        realm.delete(tracks)
      }
    } catch {
      print(error)
    }
  }
}
