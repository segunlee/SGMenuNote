//
//  SGMenuNoteViewController.swift
//  SGMenuNote
//
//  Created by SegunLee on 2017. 5. 29..
//  Copyright © 2017년 SGIOS. All rights reserved.
//

import Cocoa

class SGTextView: NSTextView {
    
    // MARK: - Initialize
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateLayoutTextView()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        updateLayoutTextView()
    }
    
    override init(frame frameRect: NSRect, textContainer container: NSTextContainer?) {
        super.init(frame: frameRect, textContainer: container)
        updateLayoutTextView()
    }
    
    
    // MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func paste(_ sender: Any?) {
        pasteAsPlainText(sender)
    }

    
    // MARK: -
    func updateLayoutTextView() {
        self.textContainerInset = NSMakeSize(5, 5)
    }
}


class SGMenuNoteViewController: NSViewController {

    // MARK: - Properties
    @IBOutlet var textView: SGTextView!
    
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        self.view.wantsLayer = true;
        self.view.layer?.backgroundColor = NSColor(white: 1, alpha: 1).cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    func switchLocation() {
        
        let listlocationsString = "networksetup -listlocations".runAsCommand()
        var listlocations = listlocationsString.components(separatedBy: "\n")
        listlocations = listlocations.filter { (str: String) -> Bool in
            return str.characters.count > 0
        }
        print(listlocations)
        
        let getcurrentlocation = "networksetup -getcurrentlocation".runAsCommand()
        print(getcurrentlocation)

        
        let switchtolocationiPhone = "networksetup -switchtolocation \"iPhone\"".runAsCommand()
        print(switchtolocationiPhone)

        /*
        networksetup -getcurrentlocation
        networksetup -listlocations
        networksetup -createlocation <location name> [populate]
        networksetup -deletelocation <location name>
        networksetup -switchtolocation <location name>
         */
    }
}
