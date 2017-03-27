// Source
// https://medium.com/@raulriera/nsoperations-nsoperationqueue-oh-my-88b707f9ba2e#.pvnq1hr3w
import Foundation

public typealias URLSessionOperationCompletion = (_ data: Data?, _ response: HTTPURLResponse?, _ error: Error?) -> Void

open class URLSessionOperation: Operation {
	
	fileprivate var task: URLSessionDataTask?
	fileprivate var completionHandler: URLSessionOperationCompletion?
	
	/**
	Returns an instance of `URLSessionOperation`
	
	- parameter session: The session that will be used for this request. The default value is `.sharedSession()`.
	- parameter url: The URL with the location of the resource to request against.
	- parameter completion: The block executed iff the request completes.
	*/
	public init(session: URLSession = .shared, url: NSURL, completion: @escaping URLSessionOperationCompletion) {
		super.init()
		
		name = url.absoluteString
		
		task = session.dataTask(with: url as URL) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
			self?.completeOperationWithBlock(completion, data: data, response: response as? HTTPURLResponse, error: error)
		}
	}
	
	open override func cancel() {
		super.cancel()
		task?.cancel()
	}
	
	
	open override func start() {
		if isCancelled {
			//_finished = true
		} else {
			//_executing = true
			task?.resume()
		}
	}
	
	// MARK: Private
	
	fileprivate func completeOperationWithBlock(_ completion: @escaping URLSessionOperationCompletion, data: Data?, response: HTTPURLResponse?, error: Error?) {
		
		if isCancelled == false {
			DispatchQueue.main.async {
				completion(data, response, error)
			}
		}
		
		//completeOperation()
	}
	
}
