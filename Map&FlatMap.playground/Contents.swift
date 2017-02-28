// --------------------------------------
// Map & FlatMap
// --------------------------------------

// MAP - does a function on each array item. 


// Each iteration is one item in the array
let numbers = [1,2,3,4,5,6]

let newNumbers = numbers.map{ $0 * 2 }
newNumbers

let newNumbers2 = numbers.flatMap{ $0 * 2 }
newNumbers2



// Flatmap flattens nested arrays
let nestedArray = [[1,2,3], [4,5,6]]

let flattenedArray = nestedArray.map { $0 }
flattenedArray // [[1,2,3], [4,5,6]]

let flattenedArray2 = nestedArray.flatMap { $0 }
flattenedArray2 // [1, 2, 3, 4, 5, 6]



// Flatmap flattens nested arrays to have ONE LESS dimension
let nestedArray2 = [    [[1,1],[2,2],[3,3]],
                        [[4,4],[5,5],[6,6]]     ]

let flattenedArray3 = nestedArray2.map { $0 }     // $0 is         [[1,1],[2,2],[3,3]]
flattenedArray3 // [[[1, 1], [2, 2], [3, 3]], [[4, 4], [5, 5], [6, 6]]]

let flattenedArray4 = nestedArray2.flatMap { $0 } // $0 is also    [[1,1],[2,2],[3,3]]
flattenedArray4 // [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6]]



// Multiply every element in nestedArray with 2
let flattened = [[1,2,3], [4,5,6]].flatMap { $0.map { $0 * 2 } }        // [2, 4, 6, 8, 10, 12]
let flattened2 = [1,2,3].map{ $0 * 2 }    +    [4,5,6].map{ $0 * 2 }    // [2, 4, 6, 8, 10, 12]
let flattened3 = [2,4,6]                  +    [8,10,12]                // [2, 4, 6, 8, 10, 12]



// Take array of optionals and return an array of unwrapped optionals without any nils.
let optionalInts: [Int?] = [1, 2, nil, 4, nil, 5]
let ints = optionalInts.flatMap { $0 }
ints // [1, 2, 4, 5]
