//
//  TrackListViewModel.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/7/20.
//

import Foundation
import UIKit

class TrackListViewModel {
  
  // MARK: - Properties
  
  var trackService = TrackService()
  var tracks: [Track] = []
  
  var controller: TrackListController?
  
  var count: Int {
    return tracks.count
  }
  
  var dummyTracks: [Track] {
    var tracks: [Track] = []
    for _ in 1...10 {
      tracks.append(Track())
    }
    return tracks
  }
  
  // Retrieves Tracks and reload collection view.
  func getTracks(collectionView: UICollectionView,
                 completion: @escaping (_ isEmpty: Bool) -> ()) {
    
    trackService.getTracks() { tracks in
      if tracks.isEmpty {
        self.tracks = self.dummyTracks //Dummy data to show TableCells
        collectionView.reloadData()
        completion(true)
      } else {
        self.tracks = tracks
        collectionView.reloadData()
        completion(false)
      }
    }
  }
  
  // Create instance of TrackCellViewModel
  func cellViewModel(indexPath: IndexPath) -> TrackCellViewModel {
    let track = tracks[indexPath.item]
    let cellViewModel = TrackCellViewModel(track: track)
    return cellViewModel
  }
}

// MARK: - UICollectionView Data Source

extension TrackListViewModel {
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCell.cellIdentifier,
                                              for: indexPath) as! TrackCell
    
    let cellViewModel = self.cellViewModel(indexPath: indexPath)
    cell.setupCell(cellViewModel: cellViewModel)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath,
                      controller: TrackListController) {
    
    self.controller = controller
    let track = tracks[indexPath.item]
    let viewModel = DetailsViewModel(track: track)
    pushDetailsController(viewModel: viewModel)
  }
}

// MARK: - Navigation Functions
extension TrackListViewModel {
  
  func pushDetailsController(viewModel: DetailsViewModel) {
    guard let navCon = controller?.navigationController else { return }
    let trackListCoordinator = TrackListCoordinator(navigationController: navCon)
    trackListCoordinator.pushDetailsController(viewModel: viewModel)
  }
  
  func pushSearchController(controller: TrackListController) {
    guard let navCon = controller.navigationController else { return }
    let searchCoordinator = TrackListCoordinator(navigationController: navCon)
    let viewModel = SearchTrackViewModel(tracks: tracks)
    searchCoordinator.pushSearchController(viewModel: viewModel)
  }
}
