# Swift3-Advanced-Syntax

## URLSessionOperation
Wraps an asychrounous network call in an Operation by subclassing Operation. Using Operation & OperationQueue, we can allow only a certain number of concurrent operations, or we can make certain calls dependent on other calls.

For example, you can run a network call C, only after network call A & B have finished.