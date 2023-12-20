import Foundation

/// A class that captures standard output and error.
///
/// - Redirects `stdout` and `stderr` to capture logs.
/// - Use `startCapture()` to begin capturing and `getOutput()` to retrieve logs.
/// - Thread-safe implementation.
///
public class StandardOutputCapture {
    private var outputPipe = Pipe()
    private var errorPipe = Pipe()
    private var output: String = ""
    private var error: String = ""
    private let queue = DispatchQueue(label: "com.logs.StandardOutputCapture")

    public init() {
        setupCapture()
    }

    private func setupCapture() {
        // Redirect stdout
        fflush(stdout)
        dup2(outputPipe.fileHandleForWriting.fileDescriptor, fileno(stdout))

        // Redirect stderr
        fflush(stderr)
        dup2(errorPipe.fileHandleForWriting.fileDescriptor, fileno(stderr))

        outputPipe.fileHandleForReading.readabilityHandler = { [weak self] handle in
            let data = handle.availableData
            if let string = String(data: data, encoding: .utf8), !string.isEmpty {
                self?.queue.async {
                    self?.output += string
                }
            }
        }

        errorPipe.fileHandleForReading.readabilityHandler = { [weak self] handle in
            let data = handle.availableData
            if let string = String(data: data, encoding: .utf8), !string.isEmpty {
                self?.queue.async {
                    self?.error += string
                }
            }
        }
    }

    /// Returns the captured standard output.
    public func getOutput() -> String {
        queue.sync {
            return output
        }
    }

    /// Returns the captured standard error output.
    public func getErrorOutput() -> String {
        queue.sync {
            return error
        }
    }
}
