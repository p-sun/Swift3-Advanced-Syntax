//: Playground - noun: a place where people can play

import UIKit

var button = UIButton()
button.titleLabel?.text

button.setTitle("set title", for: .normal)
button.titleLabel?.text

// Setting the attributed title ignores the regular setTitle
button.setAttributedTitle(NSAttributedString(string: "set attributed title"), for: .normal)
button.titleLabel?.text

// GOTCHA: In prepareForReuse, if the cell is being reused
//    Wrong:
//button.titleLabel?.text = nil
//button.titleLabel?.text // "set attributed title"
//    Correct: remove the attributed title
button.setAttributedTitle(nil, for: .normal)
button.titleLabel?.text


// SET FOR DIFFERENT STATES
var button2 = UIButton()

// If titles for all states is nil, setting title for .normal sets for all states
button2.setTitle("normal title", for: .normal)
button2.title(for: .normal)
button2.title(for: .highlighted)

// You can set a title for one specific state, which would only affect that state
button2.setTitle("highlighted title", for: .highlighted)
button2.title(for: .normal)
button2.title(for: .highlighted)
button2.title(for: .disabled)

// Since we already have an highlighted title, setting .normal only affects .normal state & any states with a nil title
button2.setTitle("another normal title", for: .normal)
button2.title(for: .normal)
button2.title(for: .highlighted)
button2.title(for: .disabled)

// for: UIControlState()      is the same as    for: .normal
button2.setTitle("title for control state", for: UIControlState())
button2.title(for: .normal)
button2.title(for: .highlighted)
button2.title(for: .disabled)
