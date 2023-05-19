//
//  SearchResultsViewController.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 19.05.2023.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject { /* 641 */
    func searchResultsViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel) /* 642 */
}

class SearchResultsViewController: UIViewController {
    
    public var titles: [Title] = [Title]() /* 450 */
    
    public weak var delegate: SearchResultsViewControllerDelegate? /* 643 */
    
    public let searchResultsCollectionView: UICollectionView = { /* 441 */
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
        return titles.count /* 488 */
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { /* 455 */
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { /* 456 */
            return UICollectionViewCell() /* 457 */
        }
        
//        cell.backgroundColor = .blue /* 458 */
        let title = titles[indexPath.row] /* 489 */
        cell.configure(with: title.poster_path ?? "") /* 490 */
        return cell /* 459 */
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { /* 644 */
        collectionView.deselectItem(at: indexPath, animated: true) /* 645 */
        
        let title = titles[indexPath.row] /* 646 */
        let titleName = title.original_title ?? "" /* 652 */
        APICaller.shared.getMovie(with: titleName) { [weak self] result in /* 648 */
            switch result { /* 649 */
            case .success(let videoElement): /* 650 */
                self?.delegate?.searchResultsViewControllerDidTapItem(TitlePreviewViewModel(title: titleName, yutubeView: videoElement, titleOverview: title.overview ?? "")) /* 647 */
            case .failure(let error): /* 650 */
                print(error.localizedDescription) /* 651 */
            
            }
        }
    }
}
