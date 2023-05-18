//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 18.05.2023.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    private let heroImageView: UIImageView = { /* 81 */
        let imageView = UIImageView() /* 82 */
        imageView.contentMode = .scaleAspectFill /* 83 */
        imageView.clipsToBounds = true /* 84 */
        imageView.image = UIImage(named: "heroImage") /* 90 */
        return imageView /* 85 */
    }()
    
    private func addGradient() { /* 93 */
        let gradientLayer = CAGradientLayer() /* 94 */
        gradientLayer.colors = [ /* 95 */
            UIColor.clear.cgColor, /* 96 */
            UIColor.systemBackground.cgColor /* 96 */
        ]
        layer.addSublayer(gradientLayer) /* 97 */
    }

    override init(frame: CGRect) { /* 77 */
        super.init(frame: frame) /* 78 */
        addSubview(heroImageView) /* 86 */
        addGradient() /* 94 */
    }
    
    override func layoutSubviews() { /* 87 */
        super.layoutSubviews() /* 88 */
        heroImageView.frame = bounds /* 89 */
    }
    
    required init?(coder: NSCoder) { /* 79 */
        fatalError() /* 80 */
    }

}
