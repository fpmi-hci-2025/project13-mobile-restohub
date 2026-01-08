// Views/Components/NavigationHeaderView.swift
import SwiftUI

struct NavigationHeaderView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var tabManager: TabManager
    
    var body: some View {
        HStack {
            Text("Restaurants")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .padding(.leading, 16)
            
            Spacer()
            
            // Кнопки корзины и заказов - ОРАНЖЕВЫЕ
            HStack(spacing: 16) {
                Button(action: {
                    // Переключаемся на вкладку Cart
                    tabManager.selectTab(1)
                }) {
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: "cart")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.orange)
                            .padding(8)
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(10)
                        
                        // Бейдж с количеством товаров
                        if cartViewModel.itemCount > 0 {
                            Text("\(cartViewModel.itemCount)")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 16, height: 16)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 8, y: -8)
                        }
                    }
                }
                
                Button(action: {
                    // Переключаемся на вкладку Orders
                    tabManager.selectTab(2)
                }) {
                    Image(systemName: "list.bullet")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.orange)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(10)
                }
            }
            .padding(.trailing, 16)
        }
        .frame(height: 60)
        .background(Color.black)
    }
}
