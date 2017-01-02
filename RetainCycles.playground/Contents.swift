// Retain cycles

import UIKit

// Example 1: Avoiding retain cycles w closures using 'weak' ----------------------

class Kraken1 {
    var notificationObserver: NSObjectProtocol?
    
    init() {
        notificationObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "humanEnteredKrakensLair"), object: nil, queue: OperationQueue.main) {
            
            // Correct
            [weak self] notification in
            self?.eatHuman()
            
            // Incorrect b/c it causes retain cycle as Kraken and NotificationCenter would both have strong references to each other, and thus neither can be deallocated from memory.
            // notification in
            // self.eatHuman()
        }
    }
    
    deinit {
        if notificationObserver != nil {
            NotificationCenter.default.removeObserver(notificationObserver!)
        }
    }
    
    func eatHuman() { print("eating human") }
}

// Example 2: Avoiding retain cycles in protocol/delegate pattern ----------------------

protocol LossOfLimbDelegate: class {
    // (Protocol inherits class b/c otherwise delegate in Tentacle can't be marked as weak)
    func limbHasBeenLost()
}

class Tentacle {
    //var delegate: LossOfLimbDelegate?     // WRONG
    weak var delegate: LossOfLimbDelegate?  // RIGHT

    func cutOffTentacle() {
        delegate?.limbHasBeenLost()
    }
}

class Kraken2: LossOfLimbDelegate {
    let tentacle = Tentacle()        // KRAKEN STRONGLY POINTS TO TENTACLE
    init() {
        tentacle.delegate = self     // TENTACLE WEAKLY POINTS TO KRAKEN
    }

    func limbHasBeenLost() {
        startCrying()
    }
    
    func startCrying() { print("tears of a Kraken") }
}

// Example 3: Avoiding retain cycles w closures using 'unowned' ----------------------

class RetainCycle {
    var closure: (() -> Void)!
    var string = "Hello"
    
    init() {
        closure = { [unowned self] in
            self.string = "Hello, World!"
        }
    }
}

let retainCycleInstance = RetainCycle()
retainCycleInstance.closure() //At this point we can guarantee the captured self inside the closure will not be nil. Any further code after this (especially code that alters self's reference) needs to be judged on whether or not unowned still works here.

// Example 4: Using unowned in lazily-defined closures ------------------------
class Kraken4 {
    let petName = "Krakey-poo"
    
    // unowned good b/c Kareken4 & businessCardName are mutually dependent, so they will always be deallocated at the same time.
    lazy var businessCardName: () -> String = { [unowned self] in
        return "Mr. Kraken AKA " + self.petName
    }
    
    // Unowned self is not needed since nothing actually retains the closure that's called by the lazy variable.
    lazy var businessCardName2: String = {
        return "Mr. Kraken AKA " + self.petName
    }()
}
