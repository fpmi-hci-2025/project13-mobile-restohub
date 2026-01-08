import SwiftUI

struct CartItemRow: View {
    let item: CartItem
    let onUpdateQuantity: (Int) -> Void
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Изображение товара
            Image(systemName: "takeoutbag.and.cup.and.straw")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.orange)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.menuItem.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                
                Text("BYN \(item.price, specifier: "%.2f") • \(item.restaurantName)")
                    .font(.system(size: 12))
                    .foregroundColor(.orange.opacity(0.8))
                
                if !item.specialInstructions.isEmpty {
                    Text(item.specialInstructions)
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            
            Spacer()
            
            // Управление количеством
            HStack(spacing: 8) {
                Button(action: {
                    if item.quantity > 1 {
                        onUpdateQuantity(item.quantity - 1)
                    } else {
                        onRemove()
                    }
                }) {
                    Image(systemName: "minus.circle")
                        .foregroundColor(.orange)
                }
                
                Text("\(item.quantity)")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(minWidth: 30)
                
                Button(action: {
                    onUpdateQuantity(item.quantity + 1)
                }) {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.orange)
                }
            }
        }
        .padding()
        .background(Color.black)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.orange.opacity(0.3), lineWidth: 1)
        )
    }
}
