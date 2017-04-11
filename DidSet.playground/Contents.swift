class Image {
	var isDowloading = true
	var name = "some name"
}

var images: [Image] = [Image(), Image()] {
	didSet {
		print("did set \(images)")
	}
}

// This doesn't call didSet
images[0].isDowloading = false
images[0].name = "another name"

// This DOES call didSet
images.append(Image())