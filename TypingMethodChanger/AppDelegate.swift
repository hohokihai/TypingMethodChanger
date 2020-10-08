//
//  AppDelegate.swift
//

import Cocoa

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {
	
	var command = Command()
	var statusItem = NSStatusItem()
	
	func applicationDidFinishLaunching(_ notification: Notification) {
		let statusBar = NSStatusBar.system
		statusItem = statusBar.statusItem(withLength:NSStatusItem.variableLength)
		statusItem.behavior = [.removalAllowed, .terminationOnRemoval]
		statusItem.button?.target = self
		statusItem.button?.action = #selector(buttonDidClick(_:))
		statusItem.button?.sendAction(on:[.leftMouseUp, .rightMouseUp])
		statusItem.isVisible = true
		buttonDidClick(nil)
	}
	
    @objc private func buttonDidClick(_ sender: NSStatusBarButton?) {
		command.execute("defaults read com.apple.inputmethod.Kotoeri JIMPrefTypingMethodKey")
		if let response = command.response, response == "1" {
			if sender != nil {
				NSApp.activate(ignoringOtherApps:true)
				command.execute("defaults write com.apple.inputmethod.Kotoeri JIMPrefTypingMethodKey 0")
				command.execute("killall JapaneseIM")
				statusItem.button?.title = "\u{FF21}"
			} else {
				statusItem.button?.title = "\u{30A2}"
			}
		} else {
			if sender != nil {
				NSApp.activate(ignoringOtherApps:true)
				command.execute("defaults write com.apple.inputmethod.Kotoeri JIMPrefTypingMethodKey 1")
				command.execute("killall JapaneseIM")
				statusItem.button?.title = "\u{30A2}"
			} else {
				statusItem.button?.title = "\u{FF21}"
			}
		}
    }
}
