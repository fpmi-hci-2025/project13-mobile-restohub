import SwiftUI

struct ErrorView: View {
    let message: String
    let retryAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(.orange)
            
            Text(message)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if let retryAction = retryAction {
                Button(action: retryAction) {
                    Text("Повторить")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.orange)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.orange, lineWidth: 1)
                        )
                }
            }
        }
        .padding()
    }
}
