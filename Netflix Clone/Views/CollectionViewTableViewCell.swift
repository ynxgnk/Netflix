//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 18.05.2023.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell" /* 46 */
    
    private let collectionView: UICollectionView = { /* 57 */
        let layout = UICollectionViewFlowLayout() /* 60 */
        layout.itemSize = CGSize(width: 140, height: 200) /* 75 */
        layout.scrollDirection = .horizontal /* 61 */
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) /* 58 */
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell") /* 62 */
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

}

extension CollectionViewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate { /* 66 */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { /* 67 */
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) /* 68 */
        cell.backgroundColor = .green /* 69 */
        return cell /* 70 */
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { /* 71 */
        10
    }
}
