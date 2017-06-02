//
//  SGPopover.swift
//  SGMenuNote
//
//  Created by SegunLee on 2017. 6. 2..
//  Copyright © 2017년 SGIOS. All rights reserved.
//

import Cocoa

class SGPopover: NSPopover {
    
    // MARK: - Initailize
    required convenience init?(coder: NSCoder) {
        self.init(coder: coder)
    }
    
    override init() {
        super.init()
    }
    
    
    // MARK: - Override
    override func show(relativeTo positioningRect: NSRect, of positioningView: NSView, preferredEdge: NSRectEdge) {
        super.show(relativeTo: positioningRect, of: positioningView, preferredEdge: preferredEdge)
        
        guard let frameView = self.contentViewController?.view.superview else {
            return
        }

        let backgroundView = NSView(frame: frameView.bounds)
        backgroundView.wantsLayer = true
        backgroundView.layer?.backgroundColor = NSColor.white.cgColor
        backgroundView.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        frameView.addSubview(backgroundView, positioned: .below, relativeTo: frameView)
    }
}
