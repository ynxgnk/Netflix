//
//  TitleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 19.05.2023.
//

import SDWebImage /* 251 */
import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell" /* 238 */
    
    private let posterImageView: UIImageView = { /* 243 */
       let imageView = UIImageView() /* 244 */
        imageView.contentMode = .scaleAspectFill /* 245 */
        return imageView /* 246 */
    }()
    
    override init(frame: CGRect) { /* 239 */
        super.init(frame: frame) /* 240 */
        contentView.addSubview(posterImageView) /* 247 */
        
    }
    
    required init?(coder: NSCoder) { /* 241 */
        fatalError() /* 242 */
    }
    
    override func layoutSubviews() { /* 248 */
        super.layoutSubviews() /* 249 */
        posterImageView.frame = contentView.bounds /* 250 */
    }
    
    public func configure(with model: String) { /* 252 */
//        guard let url = URL(string: model) else { return } /* 253 */
//        posterImageView.sd_setImage(with: url, completed: nil) /* 254 */
//        print(model) /* 294 */
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else { /* 299 */
            return /* 300 */
        }
        
        posterImageView.sd_setImage(with: url, completed: nil) /* 301 */
    }
    
}
