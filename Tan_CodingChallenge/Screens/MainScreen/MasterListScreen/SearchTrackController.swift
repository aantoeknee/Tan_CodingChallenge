//
//  SearchTrackController.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/8/20.
//

import UIKit
import RxSwift
import RxCocoa

class SearchTrackController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchTF: UITextField!
  
  let disposeBag = DisposeBag()
  var viewModel: SearchTrackViewModel? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView = setupCollectionView(collectionView: self.collectionView)
    initSearch()
  }
  
  private func initSearch() {
    searchTF.rx.text
      .orEmpty
      .asObservable()
      .distinctUntilChanged()
      .throttle(.milliseconds(400), scheduler: MainScheduler.instance)
      .subscribe(onNext: { [unowned self] searchInput in
        self.viewModel?.filterPatients(query: searchInput)
        collectionView.reloadData()
    }).disposed(by: disposeBag)
  }
  
  private func setupCollectionView(collectionView: UICollectionView) -> UICollectionView {
    let nibCell = UINib(resource: R.nib.trackCell)
    
    collectionView.register(nibCell, forCellWithReuseIdentifier: TrackCell.cellIdentifier)
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    return collectionView
  }
}

extension SearchTrackController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return viewModel?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    viewModel?.collectionView(collectionView,
                              cellForItemAt: indexPath) ?? UICollectionViewCell()
  }
  
}

extension SearchTrackController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    
    viewModel?.collectionView(collectionView,
                              didSelectItemAt: indexPath,
                              controller: self)
  }
}

extension SearchTrackController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: (view.frame.width) / 2, height: (view.frame.width - 16) / 1.5)
  }
}
