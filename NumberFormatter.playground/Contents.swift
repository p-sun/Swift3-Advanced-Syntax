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

//// Decimal formatter
let decimalFormatter = NumberFormatter()
decimalFormatter.numberStyle = NumberFormatter.Style.decimal
let j = decimalFormatter.string(from: NSNumber(value: 1230000000))

let max100Formatter = NumberFormatter()
max100Formatter.maximum = 100
max100Formatter.string(from: 123123) // 123123
max100Formatter.maximumIntegerDigits = 3
max100Formatter.string(from: 123123) // 123
max100Formatter.string(from: 100) // 123

var testInt32: AnyObject?
max100Formatter.getObjectValue(&testInt32, for: "22", errorDescription: nil) // true
testInt32 // 22
max100Formatter.getObjectValue(&testInt32, for: "333", errorDescription: nil) // false
testInt32 // Still 22 b/c value is not changed if getObjectValue fails
max100Formatter.getObjectValue(&testInt32, for: "100", errorDescription: nil) // true
testInt32 // 100 b/c maximum is 100, which is inclusive
max100Formatter.numberStyle == NumberFormatter.Style.none
extension NumberFormatter {
	func objectValueFromString<T: Any>(string: String) -> T? {
		var obj: AnyObject? = nil
		if getObjectValue(&obj, for: string, errorDescription: nil) {
			return obj as? T
		}
		return nil
	}
}
let result: Int32? = max100Formatter.objectValueFromString(string: "44") // 44
let result2: Int? = max100Formatter.objectValueFromString(string: "44") // 44
let result4: Int32? = max100Formatter.objectValueFromString(string: "-44") // 44
let result3: Int? = max100Formatter.objectValueFromString(string: "444") // nil
