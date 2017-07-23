import Foundation

// ------------------------------------------------------------
//// Regex
public struct RegularExpressionMatch {
	public let result: String
	public let range: NSRange
	
	public init(result: String, range: NSRange) {
		self.result = result
		self.range = range
	}
	
	var debugDescription: String {
		return "RESULT <\(result)> LOCATION \(range.location) LENGTH \(range.length)"
	}
}

extension String {
	public func matches(_ regex: String) -> [RegularExpressionMatch] {
		do {
			let regex = try NSRegularExpression(pattern: regex, options: [])
			let nsString = self as NSString
			let results = regex.matches(in: self, options: [], range: NSRange(location: 0, length: nsString.length))
			return results.map {
				RegularExpressionMatch(result: nsString.substring(with: $0.range), range: $0.range)
			}
		} catch {
			return []
		}
	}
}

"".matches("[0-9]*")
/*
RESULT <> LOCATION 0 LENGTH 0
*/

"abce 123".matches("[0-9]*")
/*
RESULT <> LOCATION 0 LENGTH 0
RESULT <> LOCATION 1 LENGTH 0
RESULT <> LOCATION 2 LENGTH 0
RESULT <> LOCATION 3 LENGTH 0
RESULT <> LOCATION 4 LENGTH 0
RESULT <123> LOCATION 5 LENGTH 3
RESULT <> LOCATION 8 LENGTH 0
*/

"prefix12 aaa3 prefix45".matches("fix([0-9])([0-9])")
/*
RESULT <fix12> LOCATION 3 LENGTH 5
RESULT <fix45> LOCATION 17 LENGTH 5
*/

"prefix12".matches("(?:prefix)?([0-9]+)")
/*
RESULT <prefix12> LOCATION 0 LENGTH 8
*/

"12".matches("(?:prefix)?([0-9]+)")
/*
RESULT <12> LOCATION 0 LENGTH 2
*/

"prefix12suffix".matches("fix([0-9]+)su")
/*
"RESULT <fix12su> LOCATION 3 LENGTH 7"
*/

// ------------------------------------------------------------
func generateIncrementingNames(from name: String?, count: Int) -> [String?] {
	guard count > 0 else { return [] }
	guard count != 1 else { return [name] }
	
	// If name is empty, generate nils
	guard name?.isEmpty == false else { return [name] + Array(repeatElement(nil, count: count - 1)) }
	
	// If name ends in a number, get the number
	var name = name ?? ""
	let matches = name.matches("[0-9]*[0-9]$")
	let endingNumber = Int(matches.first?.result ?? "")
	
	// Calculate prefix
	var prefix: String
	if endingNumber != nil {
		let prefixEndIndex = matches.last!.range.location
		prefix = (name as NSString).substring(to: prefixEndIndex)
	} else {
		// Append "-" to prefix if it doesn't exist already
		prefix = name.characters.last == "-" ? name : "\(name)-"
	}
	
	// Generated name = prefix + incrementing number
	return Array(0..<count).map {
		prefix + "\((endingNumber ?? 1) + $0)"
	}
}

generateIncrementingNames(from: nil, count: 3)
// [nil, nil, nil]

generateIncrementingNames(from: "", count: 3)
// ["", nil, nil]

generateIncrementingNames(from: "any", count: 1)
// ["any"]

generateIncrementingNames(from: "any12", count: 3)
// ["any12", "any13", "any14"]

generateIncrementingNames(from: "any--12", count: 3)
 ["any--12", "any--13", "any--14"]

generateIncrementingNames(from: "any", count: 3)
// ["any-1", "any-2", "any-3"]

generateIncrementingNames(from: "any-", count: 3)
// ["any-1", "any-2", "any-3"]

// ------------------------------------------------------------
// Separate numbers from a string
let numberComponent = "buy 3 apples 10eggs99"
	.components(separatedBy: CharacterSet.decimalDigits.inverted)
Int(numberComponent.last ?? "")
// 99
numberComponent.filter { $0 != ""}
// ["3", "10", "99"]
