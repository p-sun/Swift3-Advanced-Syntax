//: Playground - noun: a place where people can play

import UIKit

// Simple format
let formatted = NumberFormatter.localizedString(from: NSNumber(value: 0.075123), number: .percent)
formatted


// Add locale format
let formatter = NumberFormatter()
//formatter.mimimumFractionDigits = 1
formatter.maximumFractionDigits = 2
formatter.numberStyle = .percent
//formatter.locale = NSLocale.current // should default to the current

let x = formatter.string(from: NSNumber(value: 0.075123))

let y = formatter.string(from: NSNumber(value: 0.072))

//// Decimal formatter
let numberFormatter = NumberFormatter()
numberFormatter.generatesDecimalNumbers = true
numberFormatter.numberStyle = .decimal

let z = numberFormatter.string(from: NSNumber(value: 12.123112))
