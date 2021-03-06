//
//  TrackListController.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/7/20.
//

import TTGSnackbar
import UIKit

class TrackListController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  // Initializer
  let refreshControl = UIRefreshControl()
  var viewModel = TrackListViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initContent()
    initRefreshControler()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  private func initContent() {
    self.collectionView = setupCollectionView(collectionView: self.collectionView)
    
    activityIndicator.startAnimating()
    collectionView.isScrollEnabled = false
    
    viewModel.getTracks(collectionView: self.collectionView,
                        controller:  self) { errorString in
      
      if !(errorString?.isEmpty ?? true) {
        self.showSnackBar(message: errorString ?? "")
      }
      self.collectionView.isScrollEnabled = true
      self.activityIndicator.stopAnimating()
      self.refreshControl.endRefreshing()
    }
  }

  // MARK: - INITIALIZE UICOLLECTIONVIEW
  
  private func setupCollectionView(collectionView: UICollectionView) -> UICollectionView {
    let nibCell = UINib(resource: R.nib.trackCell)
    let nibHeader = UINib(nibName: HeaderView.cellIdentifier, bundle: nil)
    
    collectionView.register(nibHeader,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: HeaderView.cellIdentifier)
    
    collectionView.register(nibCell, forCellWithReuseIdentifier: TrackCell.cellIdentifier)
    
    collectionView.refreshControl = refreshControl
    collectionView.dataSource = self
    collectionView.delegate = self
    return collectionView
  }
  
  private func initRefreshControler() {
    refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
  }
  
  // Fetch Tracks Data when pulling to refresh
  
  @objc private func fetchData(_ sender: Any) {
    viewModel.getTracks(collectionView: self.collectionView,
                        controller: self) { errorString in
      
      if !(errorString?.isEmpty ?? true) {
        self.showSnackBar(message: errorString ?? "")
      }
      self.refreshControl.endRefreshing()
    }
  }
  
  // MARK: - Search Button Clicked
  
  @IBAction func searchButtonClicked(_ sender: Any) {
    viewModel.pushSearchController(controller: self)
  }
}

// MARK: - UICollectionView Data Source

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

// MARK: - UICollectionView Delegates

extension TrackListController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    
    viewModel.collectionView(collectionView,
                             didSelectItemAt: indexPath,
                             controller: self)
  }
}

// MARK: - UICollectionView Delegate Flow Layout

extension TrackListController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    if UIDevice.current.orientation.isLandscape {
      return CGSize(width: (view.frame.width) / 4, height: (view.frame.width - 16) / 3.5)
    } else {
      return CGSize(width: (view.frame.width) / 2, height: (view.frame.width - 16) / 1.5)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForHeaderInSection section: Int) -> CGSize {
    
    return CGSize(width: collectionView.frame.width, height: 45.0)
  }
}
