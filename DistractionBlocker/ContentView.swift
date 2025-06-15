import SwiftUI

struct ContentView: View {
    @StateObject private var nfcManager = NFCManager()

    var body: some View {
        VStack {
            Button("Start NFC Scan") {
                nfcManager.beginScanning()
            }
            .padding()
        }
        .onReceive(NotificationCenter.default.publisher(for: .nfcTagDetected)) { _ in
            BlockingManager.shared.activateBlocker()
        }
        .alert(item: $nfcManager.errorMessage) { message in
            Alert(title: Text("Error"), message: Text(message), dismissButton: .default(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
