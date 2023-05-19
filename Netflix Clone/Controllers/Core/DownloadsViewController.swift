//
//  DownloadsViewController.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 18.05.2023.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    private var titles: [TitleItem] = [TitleItem]() /* 715 */
    
    private let downloadedTable: UITableView = { /* 697 */
       let table = UITableView() /* 698 */
        table.register(TitleTableViewCell.self, /* 699 */
                       forCellReuseIdentifier: TitleTableViewCell.identifier) /* 700 */
        return table /* 701 */
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground /* 10 */
        title = "Downloads" /* 694 */
        view.addSubview(downloadedTable) /* 739 */
        navigationController?.navigationBar.prefersLargeTitles = true /* 695 */
        navigationController?.navigationItem.largeTitleDisplayMode = .always /* 696 */
        downloadedTable.delegate = self /* 702 */
        downloadedTable.dataSource = self /* 703 */
        fetchLocalStorageForDownload() /* 734 */
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Downloaded"), object: nil, queue: nil) { _ in /* 762 */
            self.fetchLocalStorageForDownload() /* 763 */
        }
    }
    
    private func fetchLocalStorageForDownload() { /* 727 */
        DataPersistenceManager.shared.fetchingTitlesFromDataBase { [weak self] result in /* 728 */
            switch result { /* 729 */
            case .success(let titles): /* 730 */
                self?.titles = titles /* 731 */
                DispatchQueue.main.async { /* 738 */
                    self?.downloadedTable.reloadData() /* 732 */
                }
            case .failure(let error): /* 730 */
                print(error.localizedDescription) /* 733 */
            }
        }
    }
    
    override func viewDidLayoutSubviews() { /* 735 */
        super.viewDidLayoutSubviews() /* 736 */
        downloadedTable.frame = view.bounds /* 737 */
    }
    
}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource { /* 704 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 705 */
        return titles.count /* 706 */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 707 */
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { /* 708 */
            return UITableViewCell() /* 709 */
        }
        
        let title = titles[indexPath.row] /* 710 */
        cell.configure(with: TitleViewModel(titleName: title.original_title ?? title.original_name ?? "Unknown title name", posterURL: title.poster_path ?? "")) /* 711 */
        return cell /* 712 */
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { /* 713 */
        return 150 /* 714 */
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { /* 750 */
        switch editingStyle { /* 751 */
        case .delete: /* 752 */
            DataPersistenceManager.shared.deleteTitleWith(model: titles[indexPath.row]) { [weak self] result in /* 754 */ /* 759 add weak self */
                switch result { /* 755 */
                case .success(): /* 756 */
                    print("Deleted from the database") /* 757 */
                case .failure(let error): /* 756 */
                    print(error.localizedDescription) /* 758 */
                }
                self?.titles.remove(at: indexPath.row) /* 760 */
                tableView.deleteRows(at: [indexPath], with: .fade) /* 753 */
            }
        default: /* 755 */
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 764 */
        tableView.deselectRow(at: indexPath, animated: true) /* 765 */
        
        let title = titles[indexPath.row] /* 766 */
        
        guard let titleName = title.original_title ?? title.original_name else { /* 767 */
            return /* 768 */
        }
        
        APICaller.shared.getMovie(with: titleName) { [weak self] result in /* 769 */
            switch result { /* 770 */
            case .success(let videoElement): /* 771 */
                DispatchQueue.main.async { /* 772 */
                    let vc = TitlePreviewViewController() /* 773 */
                    vc.configure(with: TitlePreviewViewModel(title: titleName, yutubeView: videoElement, titleOverview: title.overview ?? "")) /* 774 */
                    self?.navigationController?.pushViewController(vc, animated: true) /* 775 */
                }
            case .failure(let error): /* 776 */
                print(error.localizedDescription) /* 777 */
            
            }
        }
    }
}
