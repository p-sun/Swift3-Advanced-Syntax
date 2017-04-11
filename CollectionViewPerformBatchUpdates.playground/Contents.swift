// By Alun Bestor

import UIKit

class MyCollection: UICollectionView {
	
	override func layoutSubviews() {
		super.layoutSubviews()
		print("layout subviews")
	}
}

class MockDataSource: NSObject, UICollectionViewDataSource {
	let collectionView: MyCollection
	
	var numItems: Int
	
	init(numItems: Int) {
		self.numItems = numItems
		self.collectionView = MyCollection(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
		super.init()
		
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		collectionView.dataSource = self
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return numItems
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
	}
}

let dataSource = MockDataSource(numItems: 6)
// At this point, dataSource's collection view has not fully initialized itself:
// It has not asked its data source anything, so it has no idea how many items or sections
// there are yet.

// This triggers the collection view to ask its data source for the initial number of items.
// **If this line is commented out, the performBatchUpdates() call below will crash.**
dataSource.collectionView.layoutIfNeeded()

// Increase the item count...
dataSource.numItems += 1

// ...and tell the collection view about the items that were added.
dataSource.collectionView.performBatchUpdates({
	dataSource.collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
})

// If the collection view has properly initialized, the batch update will succeed:
// The item count that the collection view stored during layoutIfNeeded() was 6,
// the batch update adds 1 row, and the count after the update will be 7 to match
// the number reported by collectionView(_:numberOfItemsInSection:).

// If the collection view *hadn't* retrieved the initial item count yet (e.g. by
// us causing layoutIfNeeded() to be called), then performBatchUpdates() will call
// collectionView(_:numberOfItemsInSection:) itself after the increment already
// happened: so the stored item count at the start of the batch update will be 7
// instead of 6. As a result it will die with an NSInternalInconsistencyException.


