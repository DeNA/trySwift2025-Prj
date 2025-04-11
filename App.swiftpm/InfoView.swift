import SwiftUI

struct InfoView: View {
    @State var isSecretMode = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .center) {
                    
                    if isSecretMode {
                        AsyncImage(
                            url: URL(string: "https://pbs.twimg.com/profile_images/1893540152816873473/zqkOZqxS_400x400.jpg"),
                            content: {
                                $0.resizable()
                            },
                            placeholder: {
                            Circle().fill(Color.gray)
                        }).frame(
                            width: 100,
                            height: 100
                        ).mask(Circle())
                    }
                    
                    Text(isSecretMode ? "Hello this is matsuji!" : "try! Swift 2025, DeNA Booth App!")
                        .bold()
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                        .onTapGesture(count: 4) {
                            isSecretMode.toggle()
                        }
                    Text(isSecretMode ? "まつじが乗っ取った": "This app is made by try! Swift attendees!, thank you!!")
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
        .toolbar {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
            }
        }
    }
}
