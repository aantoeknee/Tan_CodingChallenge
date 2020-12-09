//
//  SearchTrackViewModel.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/9/20.
//

import Foundation
import UIKit

class SearchTrackViewModel {
  
  var controller: SearchTrackController?
  var tracks: [Track] = []
  var filteredTracks: [Track] = []
  
  var count: Int {
    return self.filteredTracks.count
  }
  
  init(tracks: [Track]) {
    self.tracks = tracks
  }
}

extension SearchTrackViewModel {
  
  // MARK: Filter function for search
  
  func filterTracks(query: String) {
    let newArray = tracks.filter {
      $0.name?.lowercased().contains(query.lowercased()) ?? false
        || $0.genre.lowercased().contains(query.lowercased())
        || String($0.price).contains(query.lowercased())
    }
    filteredTracks = newArray
  }
  
  // MARK: Create Instance of TrackCellViewModel
  
  func cellViewModel(indexPath: IndexPath) -> TrackCellViewModel {
    let track = filteredTracks[indexPath.item]
    let cellViewModel = TrackCellViewModel(track: track)
    return cellViewModel
  }
}

// MARK: - UICollectionView Data Source

extension SearchTrackViewModel {
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCell.cellIdentifier,
                                              for: indexPath) as! TrackCell
    
    let cellViewModel = self.cellViewModel(indexPath: indexPath)
    cell.setupCell(cellViewModel: cellViewModel)
    
    return cell
  }
}

// MARK: - UICollectionView Delegates

extension SearchTrackViewModel {
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath,
                      controller: SearchTrackController) {
    
    self.controller = controller
    let track = filteredTracks[indexPath.item]
    let viewModel = DetailsViewModel(track: track)
    pushDetailsController(viewModel: viewModel)
  }
}

// MARK: -  Navigation Functions

extension SearchTrackViewModel {
  
  func pushDetailsController(viewModel: DetailsViewModel) {
    guard let navCon = controller?.navigationController else { return }
    let trackListCoordinator = TrackListCoordinator(navigationController: navCon)
    trackListCoordinator.pushDetailsController(viewModel: viewModel)
  }
}
