//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 18.05.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
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
        
//        homeFeedTable.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450)) /* 76 */
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450)) /* 91 */
        homeFeedTable.tableHeaderView = headerView /* 92 */
    }
    
    override func viewDidLayoutSubviews() { /* 30 */
        super.viewDidLayoutSubviews() /* 31 */
        homeFeedTable.frame = view.bounds /* 32 */
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource { /* 35 */
    
    func numberOfSections(in tableView: UITableView) -> Int { /* 56 */
        20 
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
}
