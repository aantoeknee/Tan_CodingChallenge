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
    }).disposed(by: disposeBag)
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

extension SearchTrackController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    viewModel?.collectionView(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
  }
  
}

extension SearchTrackController: UICollectionViewDelegate {
  
  
}

extension SearchTrackController: UICollectionViewDelegateFlowLayout {
  
  
}
