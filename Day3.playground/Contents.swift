import Foundation

let fileURL = Bundle.main.url(forResource:"triangles", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

let lines = content.components(separatedBy: "\n")
var triangles = lines.map { (line) -> [String] in
	var components = line.components(separatedBy: " ")
	var rems = [Int]()
	for i in 0..<components.count {
		if components[i] == "" {
			rems.append(i)
		}
	}
	for i in (0..<rems.count).reversed() {
		components.remove(at: rems[i])
	}
	return components
}

// PART TWO ONLY: ROTATE TRIPLETS
// COMMENT THIS OUT FOR PART ONE
if triangles.last! == [] {
	triangles.popLast()
}

for i in stride(from: 0, to: triangles.count, by: 3) {
	let t1 = [triangles[i][0], triangles[i+1][0], triangles[i+2][0]]
	let t2 = [triangles[i][1], triangles[i+1][1], triangles[i+2][1]]
	let t3 = [triangles[i][2], triangles[i+1][2], triangles[i+2][2]]
	
	triangles[i] = t1
	triangles[i+1] = t2
	triangles[i+2] = t3
}
// END PART TWO ONLY

// parse triangles, count possible ones
var possibleCount = 0
for triangle in triangles {
	if triangle.count == 3 {
		if let one:Int = Int(triangle[0]), let two:Int = Int(triangle[1]), let three:Int = Int(triangle[2]) {
			var arr:[Int] = [one, two, three]
			arr.sort()
			if (arr[0] + arr[1]) > arr[2] {
				possibleCount += 1
			}
		}
	}
}

print(possibleCount)