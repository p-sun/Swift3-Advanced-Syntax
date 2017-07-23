//: Playground - noun: a place where people can play

import UIKit


extension UIScrollView {
	func fakeMoreContentAvailable() {
		self.contentOffset.y = 10
	}
	
	/// Whether or not we have scrolled to the bottom and should attempt to load more content in a paginated scroll environment.
	var moreContentAvailable: Bool {
		let viewHeight = bounds.height
		let contentHeight = contentSize.height
		let verticalOffset = contentOffset.y
		return verticalOffset > contentHeight - viewHeight
	}
}

var scrollView = UIScrollView()
scrollView.moreContentAvailable // false

scrollView.contentOffset.y = 10



scrollView.moreContentAvailable // true
