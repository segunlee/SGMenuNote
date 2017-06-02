//
//  SGMenuNoteViewController.swift
//  SGMenuNote
//
//  Created by SegunLee on 2017. 5. 29..
//  Copyright © 2017년 SGIOS. All rights reserved.
//

import Cocoa


// MARK: - SGMenuNoteViewControllerProtocol
protocol SGMenuNoteViewControllerProtocol {
    
    /// Request performClose to Popover
    ///
    /// - Parameter viewController: SGMenuNoteViewController Instance
    func menuNoteViewControllerRequestDismissPopover(_ viewController: SGMenuNoteViewController)
}


// MARK: - SGMenuNoteViewController
class SGMenuNoteViewController: NSViewController {

    // MARK: - Properties
    var delegate: SGMenuNoteViewControllerProtocol?
    
    var innerMenu: NSMenu {
        let innerMenu = NSMenu(title: "DD?")
        innerMenu.insertItem(withTitle: "About SGMenuNote", action: #selector(applicationAbout(_:)), keyEquivalent: "", at: 0)
        innerMenu.insertItem(NSMenuItem.separator(), at: 1)
        innerMenu.insertItem(withTitle: "Quit SGMenuNote", action: #selector(applicationTerminate(_:)), keyEquivalent: "", at: 2)
        return innerMenu
    }
    
    @IBOutlet var textView: SGTextView!
    
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        self.view.wantsLayer = true;
        self.view.layer?.backgroundColor = NSColor.white.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        mouseDown(with: NSEvent.init())
    }
    
    override func cancelOperation(_ sender: Any?) {
        delegate?.menuNoteViewControllerRequestDismissPopover(self)
    }
    
    
    // MARK: - Actions
    @IBAction func didTappedInnerMenuButton(_ sender: NSButton) {
        NSMenu.popUpContextMenu(innerMenu, with: NSApp.currentEvent!, for: sender)
    }
    
    func applicationAbout(_ sender: Any?) {
        
    }
    
    func applicationTerminate(_ sender: Any?) {
        NSApplication.shared().terminate(sender)
    }
    
    
    // MARK: - Study
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


// MARK: - SGTextView
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
