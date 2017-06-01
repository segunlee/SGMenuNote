//
//  AppDelegate.swift
//  SGMenuNote
//
//  Created by SegunLee on 2017. 5. 29..
//  Copyright © 2017년 SGIOS. All rights reserved.
//

import Cocoa

let SGSaveValuekey = "SGMenuNoteValueKey"

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Properties
    let statusItem = NSStatusBar.system().statusItem(withLength: -2)
    
    let popover = NSPopover()
    let noteVC = SGMenuNoteViewController(nibName: "SGMenuNoteViewController", bundle: nil)
    
    var hkm: JFHotkeyManager!
    var popoverTransiencyMonitor: Any?
    
    var darkSide: Bool = false {
        didSet {
            updateStatusBarItem(darkSide: darkSide)
        }
    }
    
    
    // MARK: - NSApplicationDelegate
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Global Hotkey Setup
        hkm = JFHotkeyManager()
        hkm.bind("option space", target: self, action: #selector(togglePopover(_:)))
        
        
        // StatusBar Item Setup
        if let button = statusItem.button {
            button.action = #selector(togglePopover(_:))
        }
        
        
        // StatusBar Menu Setup
//        let menu = NSMenu()
//        menu.addItem(NSMenuItem(title: "Toggle Note", action: #selector(togglePopover(_:)), keyEquivalent: ""))
//        menu.addItem(NSMenuItem.separator())
//        menu.addItem(NSMenuItem(title: "Quit Note", action: #selector(terminate(_:)), keyEquivalent: ""))
//        statusItem.menu = menu
        
        
        // PopOver Setup
        popover.appearance = NSAppearance(named: darkSide ? NSAppearanceNameVibrantDark : NSAppearanceNameVibrantLight)
        popover.behavior = .applicationDefined
        popover.contentViewController = noteVC
        
        if let saveValue = UserDefaults().value(forKey: SGSaveValuekey) as? String {
            noteVC?.loadView()
            noteVC?.textView.string = saveValue
        }
        
        
        
        // DarkSide Update
        WAYTheDarkSide.welcomeApplication({
            self.darkSide = true;
        }, immediately: true)
        
        WAYTheDarkSide.outcastApplication({
            self.darkSide = false;
        }, immediately: true)
    
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        if let textView = noteVC?.textView {
            UserDefaults().setValue(textView.string, forKey: SGSaveValuekey)
        }
    }


    // MARK: - Terminate
    func terminate(_ sender: AnyObject) {
//        NSApplication.shared().terminate(sender)
    }
    
    
    // MARK: - StatusBarItem UI Update
    func updateStatusBarItem(darkSide: Bool) {
        if let button = self.statusItem.button {
            button.image = NSImage(named: darkSide ? "btn_statusbar_white" : "btn_statusbar_black")
        }
    }
    
    
    // MARK: - Popover
    func showPopover(_ sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            popoverTransiencyMonitor = NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown, handler: { (event: NSEvent) in
                self.closePopover(nil)
            })
        }
    }
    
    func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
        if let val = popoverTransiencyMonitor {
            NSEvent.removeMonitor(val)
        }
        popoverTransiencyMonitor = nil
    }
    
    func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(_: sender)
        } else {
            showPopover(_: sender)
        }
    }
}

