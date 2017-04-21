
// Insertion is a mutable function

let arrayToInsert = [7, 8, 9]

var array = [1, 2, 3, 4, 5]
array.insert(contentsOf: arrayToInsert, at: 0) // [7, 8, 9, 1, 2, 3, 4, 5]

var array2 = [1, 2, 3, 4, 5]
array2.insert(contentsOf: arrayToInsert, at: 2) // [1, 2, 7, 8, 9, 3, 4, 5]

let indexToInsert = array2.index(where: { $0 == 9 }) ?? 0
array2.insert(contentsOf: [0, 0, 0], at: indexToInsert) // [1, 2, 7, 8, 0, 0, 0, 9, 3, 4, 5]

// Find FIRST item in array. Can do this with classes too, i.e. $0.name == "Lex"
if let item = arrayToInsert.first(where: { $0 == 8 }) {
	// item is the first matching array element
	let item = item // 8
}

// Find index of item in array
let index = arrayToInsert.index(where: { $0 == 8})
index // 1

// Removing a list of items from an array, in place
// [0, 1, 2, 3, 4] -> remove [2, 4, 9] = [0, 1, 3]
var array1 = [0, 1, 2, 3, 4]
array1 = array1.filter { !array2.contains($0) } // [0, 1, 3]


// removeFirst from empty array
class Foo {
	var a: Int
	var b: Int
	
	init(a: Int, b: Int) {
		self.a = a
		self.b = b
	}
}

var fooArray = [Foo(a: 1, b: 2), Foo(a: 3, b: 4)] // [{a 1, b 2}, {a 3, b 4}]
fooArray.removeFirst()
fooArray.removeFirst()
fooArray.removeFirst() // fatal error: can't remove first element from an empty collection
