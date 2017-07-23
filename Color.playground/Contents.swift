import UIKit

let purple = UIColor(red: 69.0 / 255.0, green: 77.0 / 255.0, blue: 87.0 / 255.0, alpha: 0.05)


let grey = UIColor(red: 130.0 / 255.0, green: 130.0 / 255.0, blue: 130.0 / 255.0, alpha: 1)

let similarGrey = UIColor(white: 130.0 / 255.0, alpha: 1)
let similarGrey2 = UIColor(white: 125.0 / 255.0, alpha: 1)

grey == similarGrey // false! Not the same
grey == similarGrey2 // false
grey.cgColor == similarGrey.cgColor // false
