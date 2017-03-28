// Source
// https://medium.com/@raulriera/nsoperations-nsoperationqueue-oh-my-88b707f9ba2e#.pvnq1hr3w
import Foundation

// Need this to make playground wait for the dataTask callback -------------
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
// --------------------------------------------------------------------------

public typealias URLSessionOperationCompletion = (_ data: Data?, _ response: HTTPURLResponse?, _ error: Error?) -> Void

open class URLSessionOperation: Operation {
	
	fileprivate var task: URLSessionDataTask?
//	fileprivate var completionHandler: URLSessionOperationCompletion?
	
	/**
	Returns an instance of `URLSessionOperation`
	
	- parameter session: The session that will be used for this request. The default value is `.sharedSession()`.
	- parameter url: The URL with the location of the resource to request against.
	- parameter completion: The block executed iff the request completes.
	*/
	public init(session: URLSession = .shared, url: URL, completion: @escaping URLSessionOperationCompletion) {
		super.init()
		
		name = url.absoluteString
		print("1 setting dataTask for \(name)")
		task = session.dataTask(with: url) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
			self?.completeOperationWithBlock(completion, data: data, response: response as? HTTPURLResponse, error: error)
		}
	}
	
	open override func cancel() {
		super.cancel()
		task?.cancel()
		print("dataTask cancel")
	}
	
	
	open override func start() {
		if isCancelled {
			//_finished = true
		} else {
			//_executing = true
			print("2 start(): - resuming dataTask")
			task?.resume()
		}
	}
	
	// MARK: Private
	
	fileprivate func completeOperationWithBlock(_ completion: @escaping URLSessionOperationCompletion, data: Data?, response: HTTPURLResponse?, error: Error?) {
		print("3 completeOperation w block")
		if isCancelled == false {
			DispatchQueue.main.async {
				completion(data, response, error)
				print(self.isFinished)
			}
		}
		
		//completeOperation()
//		completionBlock
	}
}


let url = URL(string: "https://www.youtube.com")!

let operation = URLSessionOperation(url: url, completion: { _, _ ,_ in print("done 1") })
let otherOperation = URLSessionOperation(url: url, completion: { _, _ ,_ in print("done 2") })
otherOperation.addDependency(operation)



let queue = OperationQueue()
queue.maxConcurrentOperationCount = 2

queue.addOperation(operation)
queue.addOperation(otherOperation)


