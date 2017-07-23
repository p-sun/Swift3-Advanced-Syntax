//: Concrete Constrained Extensions

var array: [Int] = [Int]()

extension Array where Element == Int {
	mutating func appendOne() {
		self.append(1)
	}
}

array.appendOne()
array.appendOne()

extension Optional where Wrapped == String {
	var isNilOrEmpty: Bool {
		return self?.isEmpty ?? true
	}
}
var optionalString: String? = "a"
optionalString.isNilOrEmpty // false
optionalString = nil
optionalString.isNilOrEmpty // true
optionalString = ""
optionalString.isNilOrEmpty // true
