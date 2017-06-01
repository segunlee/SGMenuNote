//
//  SGExtensions.swift
//  SGMenuNote
//
//  Created by SegunLee on 2017. 6. 1..
//  Copyright © 2017년 SGIOS. All rights reserved.
//


// MARK:- String extension
extension String {
    func runAsCommand() -> String {
        let pipe = Pipe()
        let task = Process()
        task.launchPath = ProcessInfo.processInfo.environment["SHELL"]
        task.arguments = ["-c", "-S", String(format:"%@", self)]
        task.standardOutput = pipe
        let file = pipe.fileHandleForReading
        task.launch()
        if let result = NSString(data: file.readDataToEndOfFile(), encoding: String.Encoding.utf8.rawValue) {
            return result as String
        } else {
            return "--- Error running command - Unable to initialize string from file data ---"
        }
    }
}
