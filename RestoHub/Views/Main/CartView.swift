// Views/Main/CartView.swift
import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var tabManager: TabManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Навигационная панель
                    HStack {
                        Button(action: {
                            tabManager.selectTab(0)
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 16)
                        
                        Spacer()
                        
                        Text("Cart")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        // Симметричный элемент для балансировки
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.clear)
                            .padding(.trailing, 16)
                    }
                    .frame(height: 60)
                    .background(Color.black)
                    
                    if cartViewModel.restaurantCarts.isEmpty {
                        // Контент для пустой корзины
                        VStack(spacing: 20) {
                            Spacer()
                            
                            Image(systemName: "cart")
                                .font(.system(size: 80))
                                .foregroundColor(.orange.opacity(0.5))
                            
                            Text("Your cart is empty")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.white)
                            
                            Text("Add items from restaurants to get started")
                                .font(.system(size: 14))
                                .foregroundColor(.white.opacity(0.7))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                            
                            Button(action: {
                                tabManager.selectTab(0)
                            }) {
                                Text("Browse Restaurants")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 12)
                                    .background(Color.orange)
                                    .cornerRadius(10)
                            }
                            .padding(.top, 20)
                            
                            Spacer()
                        }
                        .frame(maxHeight: .infinity)
                    } else {
                        // Контент для заполненной корзины с группировкой по ресторанам
                        ScrollView {
                            VStack(spacing: 24) {
                                ForEach(cartViewModel.sortedRestaurants, id: \.restaurantId) { restaurantCart in
                                    RestaurantCartSection(
                                        restaurantCart: restaurantCart,
                                        cartViewModel: cartViewModel
                                    )
                                }
                            }
                            .padding(.vertical)
                        }
                        
                        // Панель с итогом и кнопкой оформления заказа
                        VStack(spacing: 16) {
                            HStack {
                                Text("Total")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Text("BYN \(cartViewModel.totalPrice, specifier: "%.2f")")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.orange)
                            }
                            .padding(.horizontal)
                            
                            Button(action: {
                                // Переход к оформлению заказа
                            }) {
                                Text("Checkout")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 18)
                                    .background(Color.orange)
                                    .cornerRadius(12)
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                        }
                        .background(Color.black)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// Компонент для отображения корзины отдельного ресторана
struct RestaurantCartSection: View {
    let restaurantCart: CartViewModel.RestaurantCart
    @ObservedObject var cartViewModel: CartViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Заголовок ресторана
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(restaurantCart.restaurantName)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("\(restaurantCart.itemCount) item(s) • BYN \(restaurantCart.total, specifier: "%.2f")")
                        .font(.system(size: 14))
                        .foregroundColor(.orange)
                }
                
                Spacer()
                
                // Кнопка очистки корзины ресторана
                Button(action: {
                    cartViewModel.clearRestaurantCart(restaurantId: restaurantCart.restaurantId)
                }) {
                    Text("Clear")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.red)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            
            // Товары ресторана
            VStack(spacing: 12) {
                ForEach(restaurantCart.items) { item in
                    CartItemRow(
                        item: item,
                        onUpdateQuantity: { newQuantity in
                            cartViewModel.updateQuantity(for: item, newQuantity: newQuantity)
                        },
                        onRemove: {
                            cartViewModel.removeItem(item)
                        }
                    )
                    .padding(.horizontal)
                }
            }
        }
    }
}
