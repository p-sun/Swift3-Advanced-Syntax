//: Concrete Constrained Extensions

var array: [Int] = [Int]()

extension Array where Element == Int {
	mutating func appendOne() {
		self.append(1)
	}
}

array.appendOne()
array.appendOne()