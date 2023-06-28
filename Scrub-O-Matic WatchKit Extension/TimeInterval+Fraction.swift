//
//  Copyright © 2023 Bold Ideas. All rights reserved.
//


import Foundation

extension TimeInterval {
    
    /// The function first calculates the fraction by dividing the numerator by the denominator. It then multiplies the timeInterval by this fraction and returns the resulting value.
    ///
    /// - Parameters:
    ///     - numerator: the desired fraction's numerator
    ///     - denominator: the desired fraction's denominator
    /// - Returns: The resulting time interval. e.g. (Provided TimeInterval = 120) `numerator: 1, denominator: 4` returns `30.0`
    func fractionedWith(numerator: Int, denominator: Int) -> TimeInterval {
        let fraction = Double(numerator) / Double(denominator)
        return self * fraction
    }
}

extension TimeInterval {
    
    /// The function casts the `TimeInterval` as `Int`.
    ///
    /// - Returns: The `TimeInterval` as integer
    func asInt() -> Int {
        Int(self)
    }
}
