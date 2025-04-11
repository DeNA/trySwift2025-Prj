import SwiftUI

struct InfoView: View {
    @State var isSecreteMode = false
    var body: some View {
        List {
            Section {
                VStack(alignment: .center) {
                    Text(isSecreteMode ? "Hello this is matsuji!" : "try! Swift 2025, DeNA Booth App!")
                        .bold()
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                        .onTapGesture(count: 4) {
                            isSecreteMode.toggle()
                        }
                    Text(isSecreteMode ? "まつじが乗っ取った": "This app is made by try! Swift attendees!, thank you!!")
                        .font(.footnote)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
            }
            Section("Licenses") {
                NavigationLink("Licenses") {
                    LicenseListView()
                }
            }
        }
        .navigationTitle("Information")
    }
}
