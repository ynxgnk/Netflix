//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 19.05.2023.
//

import Foundation

struct YoutubeSearchResponse: Codable { /* 505 */
    let items: [VideoElement] /* 506 */
}

struct VideoElement: Codable { /* 507 */
    let id: IdVideoElement /* 508 */
}

struct IdVideoElement: Codable { /* 509 */
    let kind: String /* 510 */
    let videoId: String /* 510 */
}
