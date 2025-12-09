//
//  DobleFormater.swift
//  ScreenEx
//
//  Created by Ростислав on 03.12.2025.
//

import Foundation

extension Double {
    /// конвертирует значение типа  Double в  Currency, 2-6 символов после запятой
    /// ```
    /// конвертирует 1234.56 в $1,234.56
    /// конвертирует 12.345 в $12.345
    /// конвертирует 0.123456 в $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    /// конвертирует значение типа  Double в  Currency типа String, 2-6 символов после запятой
    /// ```
    /// конвертирует 1234.56 в "$1,234.56"
    /// конвертирует 12.345 в "$12.345"
    /// конвертирует 0.123456 в "$0.123456"
    ///```
    func asCurrencyWith6FractionDigits() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "0.00"
    }
    /// конвертирует значение типа  Double в  Currency типа String, 2 символов после запятой
    /// ```
    /// конвертирует 1.2345 в "1.23"
    ///```
    func fromNumberToString() -> String {
        return String(format: "%.2f", self)
    }
    /// конвертирует значение типа  Double в  Currency типа String, 2 символов после запятой + %
    /// ```
    /// конвертирует 1.2345 в "1.23%"
    ///```
    func addPercentString() -> String {
        return fromNumberToString() + "%"
    }
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.fromNumberToString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.fromNumberToString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.fromNumberToString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.fromNumberToString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.fromNumberToString()

        default:
            return "\(sign)\(self)"
        }
    }
}
