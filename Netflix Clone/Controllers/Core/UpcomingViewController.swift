//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 18.05.2023.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var titles: [Title] = [Title]() /* 321 */
    
    private let upcomingTable: UITableView = { /* 305 */
       let table = UITableView() /* 306 */
        table.register(TitleTableViewCell.self, /* 370 change UITableViewCell */
                       forCellReuseIdentifier: TitleTableViewCell.identifier) /* 307 */ /* 371 change "cell" */
        return table /* 308 */
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 8 */
        title = "Upcoming" /* 302 */
        navigationController?.navigationBar.prefersLargeTitles = true /* 303 */
        navigationController?.navigationItem.largeTitleDisplayMode = .always /* 304 */
        
        view.addSubview(upcomingTable) /* 309 */
        upcomingTable.delegate = self /* 310 */
        upcomingTable.dataSource = self /* 311 */
        
        fetchUpcoming() /* 334 */
    }

    override func viewDidLayoutSubviews() { /* 318 */
        super.viewDidLayoutSubviews() /* 319 */
        upcomingTable.frame = view.bounds /* 320 */
    }
    
    private func fetchUpcoming() { /* 322 */
        APICaller.shared.getUpcomingMovies { [weak self] result in /* 323 */ /* 326 add weak self */
            switch result { /* 324 */
            case .success(let titles): /* 325 */
                self?.titles = titles /* 327 */
                DispatchQueue.main.async { /* 329 */
                    self?.upcomingTable.reloadData() /* 328 */
                }
            case .failure(let error): /* 330 */
                print(error.localizedDescription) /* 331 */
            }
        }
    }

}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource { /* 312 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 313 */
        return titles.count /* 332 */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 314 */
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { /* 315 */ /* 372 change "cell", add guard and as */
            return UITableViewCell() /* 373 */
        }
//        cell.textLabel?.text = titles[indexPath.row].original_name ?? titles[indexPath.row].original_title ?? "Unknown" /* 316 */ /* 333 change "test" */
        
        let title = titles[indexPath.row] /* 374 */
        cell.configure(with: TitleViewModel(titleName: title.original_title ?? title.original_name ?? "Unknown title name", posterURL: title.poster_path ?? "")) /* 375 */
        return cell /* 317 */
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { /* 376 */
        return 150 /* 377 */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 614 */
        tableView.deselectRow(at: indexPath, animated: true) /* 615 */
        
        let title = titles[indexPath.row] /* 616 */
        
        guard let titleName = title.original_title ?? title.original_name else { /* 617 */
            return /* 618 */
        }
        
        APICaller.shared.getMovie(with: titleName) { [weak self] result in /* 619 */
            switch result { /* 620 */
            case .success(let videoElement): /* 621 */
                DispatchQueue.main.async { /* 626 */
                    let vc = TitlePreviewViewController() /* 622 */
                    vc.configure(with: TitlePreviewViewModel(title: titleName, yutubeView: videoElement, titleOverview: title.overview ?? "")) /* 623 */
                    self?.navigationController?.pushViewController(vc, animated: true) /* 624 */
                }
            case .failure(let error): /* 621 */
                print(error.localizedDescription) /* 625 */
            
            }
        }
    }
}
