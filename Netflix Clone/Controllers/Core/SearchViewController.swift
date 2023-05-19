//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 18.05.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    public var titles: [Title] = [Title]() /* 417 */
    
    private let discoverTable: UITableView = { /* 389 */
        let table = UITableView() /* 390 */
        table.register(TitleTableViewCell.self,
                       forCellReuseIdentifier: TitleTableViewCell.identifier) /* 391 */
        return table /* 392 */
    }()
    
    private let searchController: UISearchController = { /* 434 */
       let controller = UISearchController(searchResultsController: SearchResultsViewController()) /* 435 */
        controller.searchBar.placeholder = "Search for a Movie or TV show" /* 436 */
        controller.searchBar.searchBarStyle = .minimal /* 437 */
        return controller /* 438 */
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
        
        navigationItem.searchController = searchController /* 439 */
        
        navigationController?.navigationBar.tintColor = .white /* 440 */
        
        fetchDiscoverMovies() /* 419 */
        
        searchController.searchResultsUpdater = self /* 475 */
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 627 */
        tableView.deselectRow(at: indexPath, animated: true) /* 628 */
        
        let title = titles[indexPath.row] /* 629 */
        
        guard let titleName = title.original_title ?? title.original_name else { /* 630 */
            return /* 631 */
        }
        
        APICaller.shared.getMovie(with: titleName) { [weak self] result in /* 632 */
            switch result { /* 633 */
            case .success(let videoElement): /* 634 */
                DispatchQueue.main.async { /* 635 */
                    let vc = TitlePreviewViewController() /* 636 */
                    vc.configure(with: TitlePreviewViewModel(title: titleName, yutubeView: videoElement, titleOverview: title.overview ?? "")) /* 637 */
                    self?.navigationController?.pushViewController(vc, animated: true) /* 638 */
                }
            case .failure(let error): /* 639 */
                print(error.localizedDescription) /* 640 */
            
            }
        }
    }
    
}

extension SearchViewController: UISearchResultsUpdating { /* 476 */
    func updateSearchResults(for searchController: UISearchController) { /* 477 */
        let searchBar = searchController.searchBar /* 478 */
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else { /* 479 */
            return /* 480 */
        }
        
        APICaller.shared.search(with: query) { result in /* 481 */
            DispatchQueue.main.async { /* 482 */
                switch result { /* 483 */
                case .success(let titles): /* 484 */
                    resultsController.titles = titles /* 485 */
                    resultsController.searchResultsCollectionView.reloadData() /* 486 */
                case .failure(let error): /* 484 */
                    print(error.localizedDescription) /* 487 */
                }
            }
        }
    }
}
