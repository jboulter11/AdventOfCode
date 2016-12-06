import Foundation


// ascii extensions
extension Character {
	var asciiValue: UInt32? {
		return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
	}
}

extension String {
	func cipher(_ offset:UInt32 = 1) -> String {
		let simplifiedOffset = offset % 26
		
		return self.characters.map { (char) -> String in
			let i = char.asciiValue!
			if i == Character(" ").asciiValue! {
				// ignore spaces
				return " "
			}
			
			if i+simplifiedOffset > Character("z").asciiValue! {
				//wrap z->a
				return String(UnicodeScalar(i+simplifiedOffset-26)!)
			}
			return String(UnicodeScalar(i+simplifiedOffset)!)
			}.joined()
	}
}


// Parse input file into lines
let fileURL = Bundle.main.url(forResource:"input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

let lines = content.components(separatedBy: "\n")

var sum = 0

let regex = try NSRegularExpression(pattern: "([a-z,-]*)(\\d+)[\\[]([a-z]*)[\\]]", options: [])

for line in lines {
	let matches = regex.matches(in: line, options: [], range: NSRange(location: 0, length: line.characters.count))
	
	if matches.count > 0 && matches[0].numberOfRanges >= 3 {
		
		let ns = line as NSString
		
		let lettersWithHyphens = ns.substring(with: matches[0].rangeAt(1))
		let letters = (lettersWithHyphens as String).replacingOccurrences(of: "-", with: "")
		
		let charsAsStrings = letters.characters.map({ (charView) -> String in
			return String(charView)
		})
		
		var set = NSCountedSet(array: charsAsStrings)
		let sorted = set.sorted { (a, b) -> Bool in
			let ac = set.count(for:a)
			let bc = set.count(for:b)
			if ac == bc {
				return String(describing: a) < String(describing: b)
			} else {
				return ac > bc
			}
		}
		
		var mostStr = ""
		for i in 0..<5 {
			if let c:String = sorted[i] as? String {
				mostStr.append(c)
			}
		}
		
		let checkMost = ns.substring(with: matches[0].rangeAt(3)) as String
		//		print("\(mostStr) == \(checkMost)")
		
		if mostStr == checkMost {
			let id = ns.substring(with: matches[0].rangeAt(2)) as String
			let idint = Int(id)!
			sum += idint
			
			// simple control-f on this output to find the room you want for part 2.
			print("\(lettersWithHyphens.replacingOccurrences(of: "-", with: " ").cipher(UInt32(idint))) ID:\(idint)")
		}
	}
}
// answer to part one
print(sum)
