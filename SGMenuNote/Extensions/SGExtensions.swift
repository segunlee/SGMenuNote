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

extension NSPopover {
    
//    var backgroundView: NSView {
//        
//    }
    
//    - (NSView *)backgroundView
//    {
//    NSView *backgroundView = objc_getAssociatedObject(self, @selector(backgroundView));
//    
//    if (!backgroundView) {
//    backgroundView = [[NSView alloc] init];
//    objc_setAssociatedObject(self, @selector(backgroundView), backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popoverWillOpen:) name:NSPopoverWillShowNotification object:self];
//    }
//    
//    return backgroundView;
//    }
//    
//    - (void)popoverWillOpen:(NSNotification *)notification
//    {
//    NSView *backgroundView = self.backgroundView;
//    if (!backgroundView.superview) {
//    NSView *contentView = self.contentViewController.view;
//    NSView *frameView = [contentView superview];
//    frameView.wantsLayer = YES;
//    backgroundView.frame = NSInsetRect(frameView.frame, 1.f, 1.f);
//    backgroundView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
//    [frameView addSubview:backgroundView positioned:NSWindowBelow relativeTo:contentView];
//    }
//    }
//    
//    - (void)setBackgroundColor:(NSColor *)backgroundColor
//    {
//    NSView *backgroundView = self.backgroundView;
//    NSLog(@"setBackgroundColor: popover: %@, backgroundView: %@, color: %@", self, self.backgroundView, backgroundColor);
//    backgroundView.wantsLayer = YES;
//    backgroundView.layer.backgroundColor = [backgroundColor CGColor];
//    }
//    
//    - (NSColor *)backgroundColor
//    {
//    NSLog(@"backgroundColor: popover: %@, backgroundView: %@", self, self.backgroundView);
//    CGColorRef backgroundColor = self.backgroundView.layer.backgroundColor;
//    return backgroundColor ? [NSColor colorWithCGColor:backgroundColor] : nil;
//    }
    
}
