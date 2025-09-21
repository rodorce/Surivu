//
//  Double+EXT.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 21/09/25.
//
import Foundation

extension Double {
    func rounded(to places: Int) -> Double {
        let factor = pow(10.0, Double(places))
        return (self * factor).rounded() / factor
    }
}
