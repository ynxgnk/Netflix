//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 18.05.2023.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject { /* 581 */
    func collectionViewTableViewCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) /* 582 */
}

class CollectionViewTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionViewTableViewCell" /* 46 */
    
    weak var delegate: CollectionViewTableViewCellDelegate? /* 583 */
    
    private var titles: [Title] = [Title]() /* 266 */
    
    private let collectionView: UICollectionView = { /* 57 */
        let layout = UICollectionViewFlowLayout() /* 60 */
        layout.itemSize = CGSize(width: 140, height: 200) /* 75 */
        layout.scrollDirection = .horizontal /* 61 */
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) /* 58 */
        collectionView.register(TitleCollectionViewCell.self, /* 261 change UICollectionViewCell */
                                forCellWithReuseIdentifier: TitleCollectionViewCell.identifier) /* 62 */ /* 262 change "cell" */
        return collectionView /* 59 */
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { /* 47 */
        super.init(style: style, reuseIdentifier: reuseIdentifier) /* 48 */
        contentView.backgroundColor = .systemPink /* 49 */
        contentView.addSubview(collectionView) /* 63 */
        
        collectionView.delegate = self /* 64 */
        collectionView.dataSource = self /* 65 */
    }
    
    required init?(coder: NSCoder) { /* 50 */
        fatalError() /* 51 */
    }
    
    override func layoutSubviews() { /* 72 */
        super.layoutSubviews() /* 73 */
        collectionView.frame = contentView.bounds /* 74 */
    }
    
    public func configure(with titles: [Title]) { /* 267 */
        self.titles = titles /* 268 */
        DispatchQueue.main.async { [weak self] in /* 297 */
            self?.collectionView.reloadData() /* 298 */
        }
    }

}

extension CollectionViewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate { /* 66 */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { /* 67 */
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { /* 68 */ /* 263 add guard and change "cell" and add as? */
            return UICollectionViewCell() /* 264 */
        }
//        cell.backgroundColor = .green /* 69 */
        guard let model = titles[indexPath.row].poster_path else { /* 295 */
            return UICollectionViewCell() /* 296 */
        }
        
        cell.configure(with: model) /* 265 */ /* 293 change "" */
        return cell /* 70 */
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { /* 71 */
        return titles.count /* 292 */
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { /* 514 */
        collectionView.deselectItem(at: indexPath, animated: true) /* 515 */
        
        let title = titles[indexPath.row] /* 516 */
        guard let titleName = title.original_name ?? title.original_title else { /* 517 */
            return /* 518 */
        }
        
        APICaller.shared.getMovie(with: titleName + " trailer") { [weak self] result in /* 519 */ /* 587 add weak self */
            switch result { /* 520 */
            case .success(let videoElement): /* 521 */
                let title = self?.titles[indexPath.row] /* 584 */
                guard let titleOverview = title?.overview else { /* 588 */
                    return /* 589 */
                }
                guard let strongSelf = self else { /* 590 */
                    return /* 591 */
                }
                
                let viewModel = TitlePreviewViewModel(title: titleName, yutubeView: videoElement, titleOverview: titleOverview) /* 585 */
                self?.delegate?.collectionViewTableViewCell(strongSelf, viewModel: viewModel) /* 586 */
//                print(videoElement.id) /* 523 */
            case .failure(let error): /* 522 */
                print(error.localizedDescription) /* 523 */
            }
        }
    }
    
}
