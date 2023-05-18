//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 18.05.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = ["Trending Movies", "Popular", "Trending Tv", "Upcoming Movies", "Top Rated"] /* 140 */
    
    private let homeFeedTable: UITableView = { /* 25 */
        let table = UITableView(frame: .zero, style: .grouped) /* 26 */
        table.register(CollectionViewTableViewCell.self, /* 52 change UITableViewCell */
                       forCellReuseIdentifier: CollectionViewTableViewCell.identifier) /* 27 */ /* 53 change "cell" */
        return table /* 28 */
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 7 */
        view.addSubview(homeFeedTable) /* 29 */
        homeFeedTable.delegate = self /* 33 */
        homeFeedTable.dataSource = self /* 34 */
        
        configureNavbar() /* 128 */
        
//        homeFeedTable.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450)) /* 76 */
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500)) /* 91 */
        homeFeedTable.tableHeaderView = headerView /* 92 */
        
        getTrendingMovies() /* 169 */
    }
    
    private func configureNavbar() { /* 127 */
        var image = UIImage(named: "netflixLogo") /* 129 */
        image = image?.withRenderingMode(.alwaysOriginal) /* 131 */
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil) /* 130 */
        
        navigationItem.rightBarButtonItems = [ /* 132 */
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil), /* 133 */
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil) /* 134 */
        ]
        
        navigationController?.navigationBar.tintColor = .white /* 135 */
    }
    
    override func viewDidLayoutSubviews() { /* 30 */
        super.viewDidLayoutSubviews() /* 31 */
        homeFeedTable.frame = view.bounds /* 32 */
    }
    
    private func getTrendingMovies() { /* 167 */
        APICaller.shared.getTrendingMovies { results in /* 168 */
            switch results { /* 179 */
            case .success(let movies): /* 180 */
                print(movies)
            case .failure(let error): /* 180 */
                print(error)
            }
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource { /* 35 */
    
    func numberOfSections(in tableView: UITableView) -> Int { /* 56 */
        return sectionTitles.count /* 141 */
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 36 */
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 37 */
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { /* 38 */ /* 54 change "cell" and add guard */
         return UITableViewCell() /* 55 */
        }
//        cell.textLabel?.text = "Hello world" /* 39 */
//        cell.backgroundColor = .red /* 45 */
        return cell /* 40 */
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { /* 41 */
        200 /* 42 */
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { /* 43 */
        40 /* 44 */
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) { /* 144 */
        guard let header = view as? UITableViewHeaderFooterView else { /* 145 */
            return /* 146 */
        }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold) /* 147 */
        header.textLabel?.frame = CGRect(
            x: header.bounds.origin.x
            + 20,
            y: header.bounds.origin.y,
            width: 100,
            height: header.bounds.height
        ) /* 148 */
        header.textLabel?.textColor = .white /* 149 */
        header.textLabel?.text = header.textLabel?.text?.lowercased() /* 150 */
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { /* 142 */
        return sectionTitles[section] /* 143 */
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) { /* 136 */
        let defaultOffset = view.safeAreaInsets.top /* 137 */
        let offset = scrollView.contentOffset.y + defaultOffset /* 138 */
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset)) /* 139 */
    }
    
    
}
