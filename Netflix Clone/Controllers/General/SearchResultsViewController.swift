//
//  SearchResultsViewController.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 19.05.2023.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    private var titles: [Title] = [Title]() /* 450 */
    
    private let searchResultsCollectionView: UICollectionView = { /* 441 */
        let layout = UICollectionViewFlowLayout() /* 442 */
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3 - 10, height: 200) /* 442 */
        layout.minimumInteritemSpacing = 0 /* 460 */
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) /* 443 */
        collectionView.register(TitleCollectionViewCell.self,
                                forCellWithReuseIdentifier: TitleCollectionViewCell.identifier) /* 444 */
        return collectionView /* 445 */
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 433 */
        view.addSubview(searchResultsCollectionView) /* 446 */
        
        searchResultsCollectionView.delegate = self /* 451 */
        searchResultsCollectionView.dataSource = self /* 452 */
    }

    
    override func viewDidLayoutSubviews() { /* 447 */
        super.viewDidLayoutSubviews() /* 448 */
        searchResultsCollectionView.frame = view.bounds /* 449 */
    }

}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource { /* 453 */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { /* 454 */
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { /* 455 */
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { /* 456 */
            return UICollectionViewCell() /* 457 */
        }
        
        cell.backgroundColor = .blue /* 458 */
        return cell /* 459 */
    }
}
