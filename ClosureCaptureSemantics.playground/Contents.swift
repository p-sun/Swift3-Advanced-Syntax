
import Dispatch

class Pokemon: CustomDebugStringConvertible {
    let name: String
    init(name: String) {
        self.name = name
    }
    var debugDescription: String { return "<Pokemon \(name)>" }
    deinit { print("\(self) escaped!") }
}

func delay(seconds: Int, closure: @escaping ()->()) {
    let time = DispatchTime.now() + .seconds(seconds)
    DispatchQueue.main.asyncAfter(deadline: time) {
        print("🕑")
        closure()
    }
}

func demo1() {
    let pokemon = Pokemon(name: "Mewtwo")
    print("before closure: \(pokemon)")
    delay(seconds: 1) {
        print("inside closure: \(pokemon)")
    }
    print("bye")
}

demo1()

// Source: http://alisoftware.github.io/swift/closures/2016/07/25/closure-capture-1/