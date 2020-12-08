//
//  TrackListViewModel.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/7/20.
//

import Foundation
import UIKit

class TrackListViewModel {
  
  var trackService = TrackService()
  var tracks: [Track] = []
  
  var controller: TrackListController?
  
  var count: Int {
    return tracks.count
  }
  
  func getTracks(collectionView: UICollectionView) {
    
    trackService.getTracks() { tracks in
      if tracks.isEmpty {
        print("unable to retrieve tracks")
        collectionView.reloadData()
      } else {
        self.tracks = tracks
        collectionView.reloadData()
      }
    }
  }
}
  
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
  
  func cellViewModel(indexPath: IndexPath) -> TrackCellViewModel {
    
    let track = tracks[indexPath.item]
    let cellViewModel = TrackCellViewModel(track: track)
    return cellViewModel
  }
}

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
