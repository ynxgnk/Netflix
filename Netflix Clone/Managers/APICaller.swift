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
    
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) { /* 155 */ /* 177 change String */
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else { return } /* 157 */
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in /* 158 */
            guard let data = data, error == nil else { /* 159 */
                return /* 160 */
            }
            
            do { /* 161 */
                //                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) /* 162 */
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data) /* 174 */
                completion(.success(results.results)) /* 178 */
                //                print(results.results[0].original_title) /* 163 */
            }
            catch { /* 164 */
                print(error.localizedDescription) /* 165 */
                completion(.failure(APIError.failedToGetData)) /* 181 */
            }
        }
        task.resume() /* 166 */
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) { /* 186 */ /* 202 change String */
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else { return } /* 187 */
        let task = URLSession.shared.dataTask(with: url) { data , _, error in /* 188 */
            guard let data = data, error == nil else { /* 189 */
                return /* 190 */
            }
            
            do { /* 191 */
                //                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) /* 192 */
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data) /* 203 */
                completion(.success(results.results)) /* 193 */
            }
            catch { /* 194 */
                completion(.failure(APIError.failedToGetData)) /* 195 */
            }
        }
        
        task.resume() /* 196 */
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) { /* 204 */
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return } /* 205 */
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in /* 206 */
            guard let data = data, error == nil else { /* 207 */
                return /* 208 */
            }
            
            do { /* 209 */
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data) /* 212 */
                completion(.success(results.results)) /* 213 */
            }
            catch { /* 210 */
                completion(.failure(APIError.failedToGetData)) /* 211 */
            }
        }
        task.resume() /* 215 */
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) { /* 216 */
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return } /* 217 */
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in /* 218 */
            guard let data = data, error == nil else { /* 219 */
                return /* 220 */
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data) /* 221 */
                completion(.success(results.results)) /* 222 */
            }
            catch {
                completion(.failure(APIError.failedToGetData)) /* 223 */
            }
        }
        task.resume() /* 224 */
    }
    
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) { /* 226 */
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return } /* 227 */
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in /* 228 */
            guard let data = data, error == nil else { /* 229 */
                return /* 230 */
            }
            
            do { /* 231 */
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data) /* 232 */
                completion(.success(results.results)) /* 233 */ 
            }
            catch { /* 234 */
                completion(.failure(APIError.failedToGetData)) /* 235 */
            }
        }
        task.resume() /* 236 */ 
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) { /* 405 */
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { /* 406 */
            return /* 407 */
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in /* 408 */
            guard let data = data, error == nil else { /* 409 */
                return /* 410 */
            }
            
            do { /* 411 */
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data) /* 412 */
                completion(.success(results.results)) /* 413 */
            }
            catch { /* 414 */
                completion(.failure(APIError.failedToGetData)) /* 415 */
            }
        }
        task.resume() /* 416 */
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) { /* 461 */
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { /* 473 */
            return /* 474 */
        }
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else { /* 462 */
            return /* 463 */
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in /* 464 */
            guard let data = data, error == nil else { /* 465 */
                return /* 466 */
            }
            
            do { /* 467 */
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data) /* 468 */
                completion(.success(results.results)) /* 469 */
            }
            catch { /* 470 */
                completion(.failure(APIError.failedToGetData)) /* 471 */
            }
        }
        task.resume() /* 472 */
    }
}

