//
//  Command.swift
//

import Foundation

class Command {
	
	var data = Data()
	var response: String? {
		if data.count != 0 {
			if let string = String(data:data, encoding:String.Encoding.utf8) {
				return string.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines)
			}
		}
		return nil
	}
	
	func execute(_ string: String) {
		let pipe = Pipe()
		let process = Process()
		process.launchPath = "/bin/sh"
		process.arguments = ["-c", string]
		process.standardOutput = pipe
		process.launch()
		data = pipe.fileHandleForReading.readDataToEndOfFile()
		pipe.fileHandleForReading.closeFile()
	}
}
