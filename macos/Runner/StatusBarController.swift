//
//  StatusBarController.swift
//  Runner
//
//  Created by Ken Lee on 11/3/2022.
//

import AppKit

class StatusBarController {
    private var statusBar: NSStatusBar
    private var statusItem: NSStatusItem
    private var popover: NSPopover

    init(_ popover: NSPopover) {
        self.popover = popover
        statusBar = NSStatusBar.init()
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let statusBarButton = statusItem.button {
            statusBarButton.image = NSImage(imageLiteralResourceName: "StatusBarIcon")
            statusBarButton.image?.size = NSSize(width: 18, height: 18)
            statusBarButton.action = #selector(togglePopover(sender:))
            statusBarButton.target = self
        }
    }

    @objc func togglePopover(sender: AnyObject) {
        if(popover.isShown) {
            hidePopover(sender)
        }
        else {
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: AnyObject) {
        if let statusBarButton = statusItem.button {
            popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
        }
    }
    
    func hidePopover(_ sender: AnyObject) {
        popover.performClose(sender)
    }
}
