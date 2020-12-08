//
//  TrackListController.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/7/20.
//

import UIKit

class TrackListController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var viewModel = TrackListViewModel()
  let lastVisitedTrack = LastVisited()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let track = lastVisitedTrack.getLastTrack()
    print("DATE TIME: \(track?.dateTime)")
    self.collectionView = setupCollectionView(collectionView: self.collectionView)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    viewModel.getTracks(collectionView: self.collectionView)
  }

  private func setupCollectionView(collectionView: UICollectionView) -> UICollectionView {
    let nibCell = UINib(resource: R.nib.trackCell)
    let nibHeader = UINib(nibName: HeaderView.cellIdentifier, bundle: nil)
    
    collectionView.register(nibHeader,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: HeaderView.cellIdentifier)
    
    collectionView.register(nibCell, forCellWithReuseIdentifier: TrackCell.cellIdentifier)
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    return collectionView
  }
  
}

extension TrackListController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    
    return viewModel.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    viewModel.collectionView(collectionView, cellForItemAt: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    
      let headerView = collectionView
        .dequeueReusableSupplementaryView(ofKind: kind,
                                          withReuseIdentifier: HeaderView.cellIdentifier,
                                          for: indexPath)
    
      return headerView
    }
}
extension TrackListController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    
    viewModel.collectionView(collectionView,
                             didSelectItemAt: indexPath,
                             controller: self)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 45.0)
      }
}

extension TrackListController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: (view.frame.width) / 2, height: (view.frame.width - 16) / 1.5)
  }
}

