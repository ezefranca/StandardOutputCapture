# StandardOutputCapture

## Overview
StandardOutputCapture is a Swift framework designed to capture standard output (`stdout`) and standard error (`stderr`) in real-time. It's particularly useful for debugging, logging, and monitoring the outputs of Swift applications, especially during development.

## ⚠️ Warning
This code is experimental and not intended for production use. It should only be used for testing and development purposes. The implementation may have limitations and has not been tested for all edge cases. Use it at your own risk.

## Features
- Capture `stdout` and `stderr` in Swift applications.
- Thread-safe implementation for concurrent usage.
- Easy integration into SwiftUI or UIKit based projects.

## Installation
To integrate StandardOutputCapture into your Swift project, copy the `StandardOutputCapture.swift` file into your project directory.

## Usage
```swift
import StandardOutputCapture

// Initialize the capture
let outputCapture = StandardOutputCapture()

// Start capturing
outputCapture.startCapture()

// Retrieve captured output
let output = outputCapture.getOutput()
let errorOutput = outputCapture.getErrorOutput()

```

## SwiftUI Example

Here's a simple SwiftUI example demonstrating how to use the StandardOutputCapture in a SwiftUI app:

```swift
import SwiftUI
import StandardOutputCapture

struct ContentView: View {
    @State private var capturedOutput: String = ""
    let outputCapture = StandardOutputCapture()

    var body: some View {
        ScrollView {
            Text(capturedOutput)
                .padding()
                .font(.system(.body, design: .monospaced))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear {
            outputCapture.startCapture()
            // Periodically update the output
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                capturedOutput = outputCapture.getOutput()
            }
        }
    }
}

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

## License

StandardOutputCapture is released under the MIT License. See the LICENSE file for more information.
