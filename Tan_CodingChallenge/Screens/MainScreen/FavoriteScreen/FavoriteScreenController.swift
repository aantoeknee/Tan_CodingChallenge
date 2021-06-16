//
//  FavoriteScreenController.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Tan on 6/16/21.
//

import UIKit

class FavoriteScreenController: UIViewController {
  
  // MARK: - To monitor memory deallocation
  deinit {
    print("deinit")
  }

  // MARK: - IBOutlets
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var emptyLabelView: UIView!
  
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
    initContent()
  }
  
  private func initContent() {
    self.collectionView = setupCollectionView(collectionView: self.collectionView)
    
    activityIndicator.startAnimating()
    collectionView.isScrollEnabled = false
    
    viewModel.getTracks(collectionView: self.collectionView,
                        controller: self) { [weak self] errorString in
      
      if !(errorString?.isEmpty ?? true) {
        self?.showSnackBar(message: errorString ?? "")
      }
      self?.collectionView.isScrollEnabled = true
      self?.activityIndicator.stopAnimating()
      self?.refreshControl.endRefreshing()
      
      self?.emptyLabelView.isHidden = self?.viewModel.count != 0
    }
  }

  // MARK: - INITIALIZE UICOLLECTIONVIEW
  
  private func setupCollectionView(collectionView: UICollectionView) -> UICollectionView {
    let nibCell = UINib(resource: R.nib.trackCell)
  
    
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
  
  // MARK: - Favorites Button Clicked
  
  @IBAction func myFavoritesButtonClicked(_ sender: Any) {
    let vc = R.storyboard.main.favoriteScreenController()!
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

// MARK: - UICollectionView Data Source

extension FavoriteScreenController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    
    return viewModel.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    viewModel.collectionView(collectionView, cellForItemAt: indexPath)
  }
}

// MARK: - UICollectionView Delegates

extension FavoriteScreenController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    
    viewModel.collectionView(collectionView,
                             didSelectItemAt: indexPath,
                             controller: self)
  }
}

// MARK: - UICollectionView Delegate Flow Layout

extension FavoriteScreenController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    if UIDevice.current.orientation.isLandscape {
      return CGSize(width: (view.frame.width) / 4, height: (view.frame.width - 16) / 3.5)
    } else {
      return CGSize(width: (view.frame.width) / 2, height: (view.frame.width - 16) / 1.5)
    }
  }
}
