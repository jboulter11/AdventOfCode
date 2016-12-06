//
//  main.swift
//  Day5
//
//  Created by Jim Boulter on 12/5/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import Foundation

func MD5(string: String) -> Data? {
	guard let messageData = string.data(using:String.Encoding.utf8) else { return nil }
	var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
	
	_ = digestData.withUnsafeMutableBytes {digestBytes in
		messageData.withUnsafeBytes {messageBytes in
			CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
		}
	}
	
	return digestData
}

func printHax(_ array:Array<String>) {
	var str = ""
	for c in array {
		if c == "_" {
			str.append(String(arc4random_uniform(16), radix: 16))
		} else {
			str.append(String(c))
		}
	}
	print(str)
}

var count = 0
var arr = Array(repeating: "_", count: 8)
for i in 0..<Int.max {
	let md5Data = MD5(string:"ffykfhsq\(i)")
	let md5Hex =  md5Data!.map { String(format: "%02hhx", $0) }.joined()
	if md5Hex.hasPrefix("00000") {
		let ns:NSString = md5Hex as NSString
		
		// Part One: Pull the 6th character
//		let char = ns.substring(with: NSMakeRange(5, 1))
//		print("I: \(i) | hash: \(md5Hex) | char:\(char)")
//		count += 1
		
		// Part Two: 6th char has the position, 7th has the value
		let pos = ns.substring(with: NSMakeRange(5, 1))
		if let ipos = Int(pos) {
			if 0 <= ipos && ipos <= 7 {
				let char = ns.substring(with: NSMakeRange(6, 1))
				if(arr[ipos] == "_") {
					arr[ipos] = char
				}
				print("Added new character: " + arr.joined())
				count += 1
			}
		}
	}
	// "animation" for "decrypting"
//	printHax(arr)
	if count == 8 {
		break
	}
}
