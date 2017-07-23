//: Playground - noun: a place where people can play

import UIKit

let cell = UITableViewCell()
print("Before set \(cell.contentView.layoutMargins)")

cell.contentView.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)

cell.contentView.superview?.superview?.layoutMargins


cell.contentView.preservesSuperviewLayoutMargins = false

print("After set \(cell.contentView.layoutMargins)")


print(UIView().layoutMargins)