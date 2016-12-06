import Foundation

// Parse input file into lines
let fileURL = Bundle.main.url(forResource:"input", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

var lines = content.components(separatedBy: "\n")
lines.popLast() // pop newline from the end so we don't freak out


// we need a set for every column
var sets:[NSCountedSet] = []
for _ in 0..<lines[0].characters.count {
	sets.append(NSCountedSet())
}

// count each column
for line in lines {
	let charsAsStrings = line.characters.map({ (charView) -> String in
		return String(charView)
	})
	
	for i in 0..<charsAsStrings.count {
		sets[i].add(charsAsStrings[i])
	}
}

// sort and output the max character
var strOut = ""
for set in sets {
	let max = set.max(by: { (a, b) -> Bool in
		let ac = set.count(for:a)
		let bc = set.count(for:b)
		if ac == bc {
			// break ties alphabetically
			return String(describing: a) < String(describing: b)
		} else {
			// change to < for part 1
			return ac > bc
		}
	})
	
	strOut += max as! String
}
print(strOut)