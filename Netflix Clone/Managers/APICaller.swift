//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 18.05.2023.
//

import Foundation

struct Constants { /* 153 */
    static let API_KEY = "06fe031f3d1907efe49a957b8bcf0126" /* 154 */
    static let baseURL = "https://api.themoviedb.org" /* 156 */
}

enum APIError: Error { /* 175 */
    case failedToGetData /* 176 */
}

class APICaller { /* 151 */
    static let shared = APICaller() /* 152 */
    
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) { /* 155 */ /* 177 change String */
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else { return } /* 157 */
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in /* 158 */
            guard let data = data, error == nil else { /* 159 */
                return /* 160 */
            }
            
            do { /* 161 */
//                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) /* 162 */
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data) /* 174 */
                completion(.success(results.results)) /* 178 */
//                print(results.results[0].original_title) /* 163 */
            }
            catch { /* 164 */
                print(error.localizedDescription) /* 165 */
                completion(.failure(error)) /* 181 */
            }
        }
        task.resume() /* 166 */
    }
}
