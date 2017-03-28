//
//  ViewController.swift
//  NSURLSessionOperation
//
//  Created by Paige Sun on 2017-03-28.
//  Copyright © 2017 Paige Sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		let url = URL(string: "https://www.youtube.com")!
		let url2 = URL(string: "https://www.youtube.ca")!
		
		let operation1 = URLSessionOperation(url: url, completion: { _, _ ,_ in
			sleep(3) // For easier visualization
			print("C Operation1 Done")
		})
		let operation2 = URLSessionOperation(url: url2, completion: { _, _ ,_ in
			sleep(3)
			print("C Operation2 Done")
		})

		// Note we can add operation1 first in the queue, but start operation1 later
		operation1.addDependency(operation2)
		
		let queue = OperationQueue()
		queue.maxConcurrentOperationCount = 1
		
		queue.addOperation(operation1)
		queue.addOperation(operation2)
	}
}

public typealias URLSessionOperationCompletion = (_ data: Data?, _ response: HTTPURLResponse?, _ error: Error?) -> Void

open class URLSessionOperation: Operation {
	
	fileprivate var task: URLSessionDataTask?
	
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
		print("dataTask cancel")
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
