//
//  Neovio.swift
//  Neovio
//

import SwiftUI

@main
struct Neovio: App {
    @StateObject public var webServerManager = WebServerManager()
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        // Pass the webServerManager to the AppDelegate
        if let appDelegate = NSApplication.shared.delegate as? AppDelegate {
            appDelegate.webServerManager = webServerManager
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    webServerManager.setEnvironmentVariable(
                        name: "SECRET_KEY_BASE",
                        value: "wnHzL9tdDlP2p4Djj2Oed6f7gF0QVIwhGRS+m/zMFpHRsQtaosKm98IbZXfNmlbP"
                    )
                    webServerManager.setEnvironmentVariable(name: "PHX_HOST", value: "localhost")
                    webServerManager.setEnvironmentVariable(name: "PORT", value: "4000")
                    webServerManager.setEnvironmentVariable(name: "DEBUG", value: "true")
                    webServerManager.startServer()
                }
                .onDisappear {
                    webServerManager.stopServer()
                }
        }
    }
}

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var webServerManager: WebServerManager?

    func applicationWillTerminate(_ notification: Notification) {
        webServerManager?.stopServer()
    }
}
