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
}
