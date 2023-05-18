//
//  Movie.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 18.05.2023.
//

import Foundation

struct TrendingMoviesResponse: Codable { /* 170 */
    let results: [Movie] /* 171 */
}

struct Movie: Codable { /* 172 */
    let id: Int /* 173 */
    let media_type: String? /* 173 */
    let original_name: String? /* 173 */
    let original_title: String? /* 173 */
    let poster_path: String? /* 173 */
    let overview: String? /* 173 */
    let vote_count: Int /* 173 */
    let release_date: String? /* 173 */
    let vote_average: Double /* 173 */
}
