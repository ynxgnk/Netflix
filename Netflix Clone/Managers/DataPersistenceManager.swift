//
//  DataPersistenceManager.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 19.05.2023.
//

import Foundation
import UIKit /* 678 */
import CoreData /* 680 */

class DataPersistenceManager { /* 673 */
    
    enum DatabaseError: Error { /* 688 */
        case failedToSaveData /* 689 */
        case failedToFetchData /* 689 */
        case failedToDeletedata /* 689 */
    }
    
    static let shared = DataPersistenceManager() /* 674 */
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void) { /* 675 */
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { /* 676 */
            return /* 677 */
        }
        
        let context = appDelegate.persistentContainer.viewContext /* 679 */
        
        let item = TitleItem(context: context) /* 681 */
        
        item.original_title = model.original_title /* 682 */
        item.id = Int64(model.id) /* 682 */
        item.original_name = model.original_name /* 682 */
        item.overview = model.overview /* 682 */
        item.media_type = model.media_type /* 682 */
        item.poster_path = model.poster_path /* 682 */
        item.release_date = model.release_date /* 682 */
        item.vote_count = Int64(model.vote_count) /* 682 */
        item.vote_avarage = model.vote_average /* 682 */
        
        do { /* 683 */
            try context.save() /* 684 */
            completion(.success(())) /* 687 */
        }
        catch { /* 685 */
            completion(.failure(DatabaseError.failedToSaveData)) /* 686 */
        }
    }
    
    func fetchingTitlesFromDataBase(completion: @escaping (Result<[TitleItem], Error>) -> Void) { /* 716 */
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { /* 717 */
            return /* 718 */
        }
        
        let context = appDelegate.persistentContainer.viewContext /* 719 */
        
        let request: NSFetchRequest<TitleItem> /* 720 */
        
        request = TitleItem.fetchRequest() /* 721 */
        
        do { /* 722 */
            let titles = try context.fetch(request) /* 725 */
            completion(.success(titles)) /* 726 */
        }
        catch { /* 723 */
            completion(.failure(DatabaseError.failedToFetchData)) /* 724 */
        }
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) { /* 740 */
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { /* 741 */
            return /* 742 */
        }
        
        let context = appDelegate.persistentContainer.viewContext /* 743 */
        
        context.delete(model) /* 744 */
        
        do { /* 745 */
            try context.save() /* 746 */
            completion(.success(())) /* 747 */
        }
        catch { /* 748 */
            completion(.failure(DatabaseError.failedToDeletedata)) /* 749 */
        }
    }
}
