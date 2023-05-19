//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 19.05.2023.
//

import UIKit
import WebKit /* 524 */

class TitlePreviewViewController: UIViewController {
    
    private let titleLabel: UILabel = { /* 526 */
        let label = UILabel() /* 527 */
        label.translatesAutoresizingMaskIntoConstraints = false /* 530 */
        label.font = .systemFont(ofSize: 22, weight: .bold) /* 531 */
        label.text = "Harry potter" /* 561 */
        return label /* 529 */
    }()
    
    private let overviewLabel: UILabel = { /* 532 */
       let label = UILabel() /* 533 */
        label.font = .systemFont(ofSize: 18, weight: .regular) /* 534 */
        label.translatesAutoresizingMaskIntoConstraints = false /* 535 */
        label.numberOfLines = 0 /* 536 */
        label.text = "This is the best movie to watch as a kid" /* 562 */
        return label /* 537 */
    }()
    
    private let downloadButton: UIButton = { /* 538 */
       let button = UIButton() /* 539 */
        button.translatesAutoresizingMaskIntoConstraints = false /* 540 */
        button.backgroundColor = .red /* 541 */
        button.setTitle("Download", for: .normal) /* 542 */
        button.setTitleColor(.white, for: .normal) /* 543 */
        button.layer.cornerRadius = 8 /* 573 */
        button.layer.masksToBounds = true /* 574 */
        return button /* 544 */
    }()

    private let webView: WKWebView = { /* 525 */
        let webView = WKWebView() /* 566 */
        webView.translatesAutoresizingMaskIntoConstraints = false /* 567 */
        return webView /* 568 */
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 572 */
        view.addSubview(webView) /* 545 */
        view.addSubview(titleLabel) /* 546 */
        view.addSubview(overviewLabel) /* 547 */
        view.addSubview(downloadButton) /* 548 */
        
        configureConstraints() /* 550 */

    }
    
    func configureConstraints() { /* 549 */
        let webViewConstraints = [ /* 551 */
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50), /* 552 */
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor), /* 552 */
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor), /* 552 */
            webView.heightAnchor.constraint(equalToConstant: 300) /* 552 */
        ]
        
        let titleLabelConstraints = [ /* 553 */
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20), /* 554 */
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20) /* 554 */
        ]
        
        let overviewLabelConstraints = [ /* 555 */
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15), /* 556 */
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), /* 557 */
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor) /* 557 */
        ]
        
        let downloadButtonConstraint = [ /* 569 */
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor), /* 570 */
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25), /* 570 */
            downloadButton.widthAnchor.constraint(equalToConstant: 140), /* 570 */
            downloadButton.heightAnchor.constraint(equalToConstant: 40) /* 570 */
        ]
        
        NSLayoutConstraint.activate(webViewConstraints) /* 558 */
        NSLayoutConstraint.activate(titleLabelConstraints) /* 559 */
        NSLayoutConstraint.activate(overviewLabelConstraints) /* 560 */
        NSLayoutConstraint.activate(downloadButtonConstraint) /* 571 */
    }
    
    func configure(with model: TitlePreviewViewModel) { /* 575 */
        titleLabel.text = model.title /* 576 */
        overviewLabel.text = model.titleOverview /* 577 */
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.yutubeView.id.videoId)") else { /* 578 */
            return /* 579 */
        }
        
        webView.load(URLRequest(url: url)) /* 580 */
    }

}
