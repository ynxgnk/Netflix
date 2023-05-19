//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 18.05.2023.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    private let downloadButton: UIButton = { /* 112 */
       let button = UIButton() /* 113 */
        button.setTitle("Download", for: .normal) /* 114 */
        button.layer.borderColor = UIColor.white.cgColor /* 115 */
        button.layer.borderWidth = 1 /* 116 */
        button.translatesAutoresizingMaskIntoConstraints = false /* 117 */
        button.layer.cornerRadius = 5 /* 125 */
        return button /* 118 */
    }()
    
    private let playButton: UIButton = { /* 99 */
       let button = UIButton() /* 100 */
        button.setTitle("Play", for: .normal) /* 102 */
        button.layer.borderColor = UIColor.white.cgColor /* 103 */
        button.layer.borderWidth = 1 /* 104 */
        button.translatesAutoresizingMaskIntoConstraints = false /* 105 */
        button.layer.cornerRadius = 5 /* 126 */
        return button /* 101 */
    }()
    
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
        gradientLayer.frame = bounds /* 98 */
        layer.addSublayer(gradientLayer) /* 97 */
    }

    override init(frame: CGRect) { /* 77 */
        super.init(frame: frame) /* 78 */
        addSubview(heroImageView) /* 86 */
        addGradient() /* 94 */
        addSubview(playButton) /* 106 */
        addSubview(downloadButton) /* 119 */
        applyConstraints() /* 109 */
    }
    
    private func applyConstraints() { /* 106 */
        let playButtonConstraints = [ /* 107 */
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70), /* 108 */
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50), /* 109 */
            playButton.widthAnchor.constraint(equalToConstant: 120) /* 111 */
        ]
        
        let downloadButtonConstraints = [ /* 120 */
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70), /* 121 */
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50), /* 122 */
            downloadButton.widthAnchor.constraint(equalToConstant: 120) /* 123 */
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints) /* 110 */
        NSLayoutConstraint.activate(downloadButtonConstraints) /* 124 */
    }
    
    public func configure(with model: TitleViewModel) { /* 607 */
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { /* 608 */
            return /* 609 */
        }
        
        heroImageView.sd_setImage(with: url, completed: nil) /* 610 */
    }
    
    override func layoutSubviews() { /* 87 */
        super.layoutSubviews() /* 88 */
        heroImageView.frame = bounds /* 89 */
    }
    
    required init?(coder: NSCoder) { /* 79 */
        fatalError() /* 80 */
    }

}
