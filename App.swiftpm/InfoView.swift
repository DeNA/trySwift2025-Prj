import SwiftUI

struct InfoView: View {
    @State var isSecretMode = false
    @Environment(\.dismiss) private var dismiss
    @State private var xOffset = 0.0
    
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
                    if #available(iOS 18.0, *) {
                        Text(isSecretMode ? "まつじが乗っ取った": "This app is made by try! Swift attendees!, thank you!!")
                            .customAttribute(RainbowAttribute())
                            .font(.footnote)
                            .textRenderer(RainbowRenderer(xOffset: xOffset))
                    } else {
                        // Fallback on earlier versions
                    }
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

struct RainbowAttribute: TextAttribute {}

struct RainbowRenderer: TextRenderer {
    var xOffset: Double
    
    // TODO: 16以下何とかして
    @available(iOS 17.0, *)
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        for line in layout {
            for run in line {
                if run[RainbowAttribute.self] != nil {
                    var copy = ctx
                    copy.addFilter(
                        .colorShader(
                            ShaderLibrary.rainbow(.float2(run.typographicBounds.rect.size), .float(xOffset))
                        )
                    )
                    copy.draw(run)
                } else {
                    ctx.draw(run)
                }
            }
        }
    }
}
