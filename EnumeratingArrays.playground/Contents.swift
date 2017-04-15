
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
