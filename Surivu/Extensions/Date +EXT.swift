//
//  Date +EXT.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 23/09/25.
//

import Foundation

extension Date {
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
