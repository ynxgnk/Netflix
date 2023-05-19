//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 19.05.2023.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell" /* 335 */
    
    private let playTitleButton: UIButton = { /* 351 */
        let button = UIButton() /* 352 */
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)) /* 383 */
        button.setImage(image, for: .normal) /* 378 */ /* 384 change UIImage(..) */
        button.translatesAutoresizingMaskIntoConstraints = false /* 353 */
        button.tintColor = .white /* 382 */
        return button /* 354 */
    }()
    
    private let titleLabel: UILabel = { /* 345 */
        let label = UILabel() /* 346 */
        label.translatesAutoresizingMaskIntoConstraints = false /* 347 */
        return label /* 348 */
    }()
    
    private let titlesPosterUIImageView: UIImageView = { /* 341 */
       let imageView = UIImageView() /* 342 */
        imageView.contentMode = .scaleAspectFill /* 343 */
        imageView.translatesAutoresizingMaskIntoConstraints = false /* 349 */
        imageView.clipsToBounds = true /* 385 */
        return imageView /* 344 */
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { /* 336 */
        super.init(style: style, reuseIdentifier: reuseIdentifier) /* 337 */
        contentView.addSubview(titlesPosterUIImageView) /* 338 */
        contentView.addSubview(titleLabel) /* 350 */
        contentView.addSubview(playTitleButton) /* 355 */
        
        applyConstraints() /* 357 */
    }
    
    private func applyConstraints() { /* 356 */
        let titlesPosterUIImageViewConstraints = [ /* 357 */
            titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), /* 358 */
            titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10), /* 358 */
            titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10), /* 358 */
            titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 100) /* 358 */
        ]
        
        let titleLabelConstraints = [ /* 367 */
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 20), /* 368 */
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), /* 368 */
        ]
        
        let playTitleButtonConstraints = [ /* 379 */
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20), /* 380 */
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor) /* 380 */
        ]
        
        NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints) /* 359 */
        NSLayoutConstraint.activate(titleLabelConstraints) /* 369 */
        NSLayoutConstraint.activate(playTitleButtonConstraints) /* 381 */
    }
    
    public func configure(with model: TitleViewModel) { /* 360 */
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { /* 361 */
            return /* 362 */
        }
        
        titlesPosterUIImageView.sd_setImage(with: url, completed: nil) /* 363 */
        titleLabel.text = model.titleName /* 364 */
    }
    
    required init?(coder: NSCoder) { /* 339 */
        fatalError() /* 340 */
    }
    
}
