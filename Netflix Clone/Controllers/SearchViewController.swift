//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 18.05.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var titles: [Title] = [Title]() /* 417 */
    
    private let discoverTable: UITableView = { /* 389 */
        let table = UITableView() /* 390 */
        table.register(TitleTableViewCell.self,
                       forCellReuseIdentifier: TitleTableViewCell.identifier) /* 391 */
        return table /* 392 */
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 9 */
        title = "Search" /* 386 */
        navigationController?.navigationBar.prefersLargeTitles = true /* 387 */
        navigationController?.navigationItem.largeTitleDisplayMode = .always /* 388 */
        
        view.addSubview(discoverTable) /* 393 */
        discoverTable.delegate = self /* 397 */
        discoverTable.dataSource = self /* 398 */
        
        fetchDiscoverMovies() /* 419 */
    }
    
    private func fetchDiscoverMovies() { /* 418 */
        APICaller.shared.getDiscoverMovies { [weak self] result in /* 420 */
            switch result { /* 421 */
            case .success(let titles): /* 422 */
                self?.titles = titles /* 423 */
                DispatchQueue.main.async { /* 424 */
                    self?.discoverTable.reloadData() /* 425 */
                }
            case .failure(let error): /* 422 */
                print(error.localizedDescription) /* 426 */
            }
        }
    }
    
    override func viewDidLayoutSubviews() { /* 394 */
        super.viewDidLayoutSubviews() /* 395 */
        discoverTable.frame = view.bounds /* 396 */
    }
  
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource { /* 399 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 400 */
        return titles.count /* 427 */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 401 */
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { /* 402 */
            return UITableViewCell() /* 403 */
        }
        
        let title = titles[indexPath.row] /* 429 */
        let model = TitleViewModel(titleName: title.original_name ?? title.original_title ?? "Unknown name", posterURL: title.poster_path ?? "") /* 430 */
        cell.configure(with: model) /* 428 */
        return cell /* 404 */
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { /* 431 */
        return 150 /* 432 */
    }
}
