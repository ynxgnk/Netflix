//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Nazar Kopeika on 19.05.2023.
//

import Foundation

extension String { /* 182 */
    func capitalizeFirstLetter() -> String { /* 183 */
        return self.prefix(1).uppercased() + self.lowercased().dropFirst() /* 184 */
    }
}
