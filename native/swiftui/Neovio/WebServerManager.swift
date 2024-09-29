//
//  WebServerManager.swift
//  Neovio
//
//  Created by Benjamin Milde on 28.09.24.
//

import Foundation
import Combine
import os

class WebServerManager: ObservableObject {
    @Published private(set) var isRunning: Bool = false
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "WebServerManager")
    private var process: Process?
    private var outputPipe: Pipe?
    private var errorPipe: Pipe?
    private var environmentVariables: [String: String] = [:]

    func setEnvironmentVariable(name: String, value: String) {
        environmentVariables[name] = value
    }

    func startServer() {
        logger.info("Attempting to start server...")
        
        guard let bundlePath = Bundle.main.path(forResource: "neovio_macos", ofType: nil) else {
            logger.error("Binary not found in bundle")
            return
        }
        logger.debug("Binary found at path: \(bundlePath)")

        process = Process()
        process?.executableURL = URL(fileURLWithPath: bundlePath)
        
        // Set environment variables
        if !environmentVariables.isEmpty {
            var currentEnv = ProcessInfo.processInfo.environment
            currentEnv.merge(environmentVariables) { (_, new) in new }
            process?.environment = currentEnv
        }
        
        outputPipe = Pipe()
        errorPipe = Pipe()
        process?.standardOutput = outputPipe
        process?.standardError = errorPipe

        do {
            logger.debug("Attempting to run process...")
            try process?.run()
            isRunning = true
            logger.info("Process started successfully")
                        
            // Handle output
            outputPipe?.fileHandleForReading.readabilityHandler = { [weak self] handle in
                self?.handleOutput(handle: handle, isError: false)
            }
            
            // Handle errors
            errorPipe?.fileHandleForReading.readabilityHandler = { [weak self] handle in
                self?.handleOutput(handle: handle, isError: true)
            }
        } catch {
            logger.error("Failed to start server: \(error.localizedDescription)")
        }
    }
    
    private func handleOutput(handle: FileHandle, isError: Bool) {
        let data = handle.availableData
        if let output = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines), !output.isEmpty {
            if isError {
                logger.error("Server error: \(output, privacy: .public)")
            } else {
                logger.info("Server output: \(output, privacy: .public)")
            }
        }
    }

    func stopServer() {
        logger.info("Stopping server...")
        process?.terminate()
        process = nil
        outputPipe?.fileHandleForReading.readabilityHandler = nil
        errorPipe?.fileHandleForReading.readabilityHandler = nil
        isRunning = false
        logger.info("Server stopped")
    }
}
