import Foundation

let today = Date()
let formatter = DateFormatter()

formatter.dateStyle = DateFormatter.Style.full // "Wednesday, August 23, 2017"
formatter.string(from: today)

formatter.dateStyle = DateFormatter.Style.long // "August 23, 2017"
formatter.string(from: today)

formatter.dateStyle = DateFormatter.Style.medium // "Aug 23, 2017"
formatter.string(from: today)


formatter.dateStyle = DateFormatter.Style.short // "8/23/17"
formatter.string(from: today)

today.description // "2017-08-23 19:34:52 +0000"
