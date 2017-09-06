// Regular Expressions
import Foundation

extension String {
    // Matches string between two characters, excluding delimiters.
    func substring(between start: Character, until end: Character) -> String? {
        guard contains(end.description) else { return nil }
        
        if let match = range(of: "(?<=\(start))[^\(end)]+", options: .regularExpression) {
            return substring(with: match)
        }
        return nil
    }
    
    // Matches string between two characters, including delimiters.
    func substring(between start: Character, to end: Character) -> String? {
        if let match = range(of: "\(start).*\(end)", options: .regularExpression) {
            return substring(with: match)
        }
        return nil
    }
}

"START-MIDDLE-END".substring(between: Character("T"), until: Character("L")) // "ART-MIDD"
"START-MIDDLE-END".substring(between: Character("T"), to: Character("L")) // "ART-MIDD"

"START-MIDDLE-END".substring(between: Character("T"), until: Character("X")) // nil
"START-MIDDLE-END".substring(between: Character("T"), to: Character("X")) // nil

"START-MIDDLE-END".substring(between: Character("X"), until: Character("L")) // nil
"START-MIDDLE-END".substring(between: Character("X"), to: Character("L")) // nil



