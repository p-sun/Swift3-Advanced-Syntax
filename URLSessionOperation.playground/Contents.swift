// Example of an Operation subclass, where the operation runs asynchronously.
// Using Operation & OperationQueue, we can allow only a certain number of concurrent operations,
// or we can make certain calls dependent on other calls.
// For example, you can run a network call C, only after network call A & B have finished.

import Foundation

// Allow asynchronous in Playground
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)

public typealias URLSessionOperationCompletion = (_ data: Data?, _ response: HTTPURLResponse?, _ error: Error?) -> Void

open class URLSessionOperation: Operation {
	
	private var task: URLSessionDataTask?
	private var _executing = false
	private var _finished = false
	
	/**
	Returns an instance of `URLSessionOperation`
	
	- parameter session: The session that will be used for this request. The default value is `.sharedSession()`.
	- parameter url: The URL with the location of the resource to request against.
	- parameter completion: The block executed iff the request completes.
	*/
	public init(session: URLSession = .shared, url: URL, completion: @escaping URLSessionOperationCompletion) {
		super.init()
		
		name = url.absoluteString
		print("A setting dataTask for \(name)")
		task = session.dataTask(with: url) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
			self?.completeOperationWithBlock(completion, data: data, response: response as? HTTPURLResponse, error: error)
		}
	}
	
	open override func cancel() {
		super.cancel()
		task?.cancel()
		finish()
	}
	
	open override func start() {
		
		if isCancelled {
			finish()
		} else {
			willChangeValue(forKey: "isExecuting")
			_executing = true
			didChangeValue(forKey: "isExecuting")
			
			print("B start(): - resuming dataTask for \(self)")
			task?.resume()
		}
	}
	
	func finish() {
		willChangeValue(forKey: "isExecuting")
		willChangeValue(forKey: "isFinished")
		_executing = false
		_finished = true
		didChangeValue(forKey: "isExecuting")
		didChangeValue(forKey: "isFinished")
	}
	
	override open var isExecuting: Bool {
		return _executing
	}
	
	override open var isFinished: Bool {
		return _finished
	}
	
	// MARK: Private
	
	fileprivate func completeOperationWithBlock(_ completion: @escaping URLSessionOperationCompletion, data: Data?, response: HTTPURLResponse?, error: Error?) {
		if isCancelled == false {
			DispatchQueue.main.async {
				completion(data, response, error)
				self.finish()
			}
		}
	}
}



let url = URL(string: "https://www.youtube.com")!
let url2 = URL(string: "https://www.youtube.ca")!

let operation1 = URLSessionOperation(url: url, completion: { _, _ ,_ in
	sleep(2) // For easier visualization
	print("C Operation1 Done")
})
let operation2 = URLSessionOperation(url: url2, completion: { _, _ ,_ in
	sleep(2)
	print("C Operation2 Done")
})

// Note we can add operation1 first in the queue, but start operation1 later
operation1.addDependency(operation2)
//operation2.addDependency(operation1)

let queue = OperationQueue()
queue.maxConcurrentOperationCount = 1

queue.addOperation(operation1)
queue.addOperation(operation2)
