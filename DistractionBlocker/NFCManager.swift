import Foundation
import CoreNFC

class NFCManager: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {
    private var session: NFCNDEFReaderSession?
    @Published var errorMessage: String?

    func beginScanning() {
        guard NFCNDEFReaderSession.readingAvailable else {
            errorMessage = "NFC scanning not available on this device"
            return
        }
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.begin()
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
        }
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        DispatchQueue.main.async {
            // Placeholder for activating blocking logic
            NotificationCenter.default.post(name: .nfcTagDetected, object: nil)
        }
    }
}

extension Notification.Name {
    static let nfcTagDetected = Notification.Name("nfcTagDetected")
}
