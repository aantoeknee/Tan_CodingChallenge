//
//  TrackListCoordinator.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/8/20.
//

import Foundation
import UIKit

class TrackListCoordinator {
  
  var navigationController: UINavigationController? = nil
  
  convenience init(navigationController: UINavigationController) {
    self.init()
    self.navigationController = navigationController
  }
  
  // MARK: - Push Details Controller
  func pushDetailsController(viewModel: DetailsViewModel) {
    let detailsController = R.storyboard.main.detailsController()!
    detailsController.viewModel = viewModel
    navigationController?.pushViewController(detailsController, animated: true)
  }
  
  // MARK: - Push Search Controller
  func pushSearchController(viewModel: SearchTrackViewModel) {
    let searchController = R.storyboard.main.searchTrackController()!
    searchController.viewModel = viewModel
    navigationController?.pushViewController(searchController, animated: true)
  }
  
  //MARK: - Push Favorites Controller
  func pushFavoritesController() {
    let favoritesController = R.storyboard.main.favoriteScreenController()!
    navigationController?.pushViewController(favoritesController, animated: true)
  }
}
