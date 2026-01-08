//import SwiftUI
//
//struct CheckoutView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @EnvironmentObject var cartViewModel: CartViewModel
//    @EnvironmentObject var ordersViewModel: OrdersViewModel
//    
//    @State private var deliveryAddress = "Poland, Warsaw, Kupwina Typoskiego 4, Block 2, Entrance 1, 15"
//    @State private var paymentMethod = "Cash"
//    @State private var comment = ""
//    
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(spacing: 24) {
//                    // Заголовок
//                    HStack {
//                        Button("Back to cart") {
//                            presentationMode.wrappedValue.dismiss()
//                        }
//                        .foregroundColor(.blue)
//                        
//                        Spacer()
//                        
//                        Text("Checkout")
//                            .font(.headline)
//                        
//                        Spacer()
//                        
//                        Text("")
//                            .frame(width: 80)
//                    }
//                    .padding()
//                    
//                    // Информация о ресторане
//                    VStack(alignment: .leading, spacing: 16) {
//                        Text("Domino's")
//                            .font(.title2)
//                            .fontWeight(.semibold)
//                        
//                        // Адрес доставки
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Delivery address")
//                                .font(.headline)
//                            Text(deliveryAddress)
//                                .foregroundColor(.gray)
//                        }
//                        
//                        // Способ оплаты
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Payment")
//                                .font(.headline)
//                            
//                            HStack {
//                                Text(paymentMethod)
//                                Spacer()
//                                Button("Change") {
//                                    // Изменить способ оплаты
//                                }
//                                .foregroundColor(.blue)
//                            }
//                            
//                            if paymentMethod == "Card" {
//                                Text("Default card: … 4242")
//                                    .font(.caption)
//                                    .foregroundColor(.gray)
//                            }
//                        }
//                        
//                        // Комментарий для курьера
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Comment for courier")
//                                .font(.headline)
//                            TextField("For example: call me 5 minutes before arrival", text: $comment)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                        }
//                    }
//                    .padding()
//                    
//                    // Кнопка оформления заказа
//                    Button(action: {
//                        let newOrder = Order(
//                            id: "R25R\(Int.random(in: 100000000...999999999))",
//                            restaurantName: "Domino's",
//                            items: cartViewModel.items,
//                            total: cartViewModel.totalPrice,
//                            status: "Order accepted"
//                        )
//                        
//                        ordersViewModel.addOrder(newOrder)
//                        cartViewModel.clearCart()
//                        presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Text("Place order")
//                            .fontWeight(.semibold)
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                    .padding()
//                }
//            }
//            .navigationBarHidden(true)
//        }
//    }
//}

// Views/Main/CheckoutView.swift
import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var deliveryAddress = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Навигационная панель
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 16)
                        
                        Spacer()
                        
                        Text("Checkout")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Spacer()
                            .frame(width: 40)
                    }
                    .frame(height: 60)
                    .background(Color.black)
                    
                    ScrollView {
                        VStack(spacing: 24) {
                            // Раздел доставки
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Delivery Address")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.orange)
                                
                                TextField("Enter your address", text: $deliveryAddress)
                                    .padding()
                                    .background(Color.black)
                                    .cornerRadius(8)
                                    .foregroundColor(.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.orange, lineWidth: 1)
                                    )
                            }
                            .padding(.horizontal)
                            .onAppear {
                                // Инициализируем адрес, если пользователь уже ввел его
                                if let userEmail = userViewModel.currentUser?.email {
                                    deliveryAddress = "Address for \(userEmail)"
                                }
                            }
                            
                            // Раздел оплаты
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Payment Method")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.orange)
                                
                                HStack {
                                    Image(systemName: "creditcard")
                                        .foregroundColor(.orange)
                                    
                                    Text("Add payment method")
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.orange)
                                }
                                .padding()
                                .background(Color.black)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.orange, lineWidth: 1)
                                )
                            }
                            .padding(.horizontal)
                            
                            // Итоговая сумма
                            VStack(spacing: 12) {
                                HStack {
                                    Text("Subtotal")
                                        .font(.system(size: 14))
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Spacer()
                                    
                                    Text("BYN \(cartViewModel.totalPrice, specifier: "%.2f")")
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                }
                                
                                HStack {
                                    Text("Delivery Fee")
                                        .font(.system(size: 14))
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Spacer()
                                    
                                    Text("BYN 2.00")
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                }
                                
                                Divider()
                                    .background(Color.orange.opacity(0.3))
                                
                                HStack {
                                    Text("Total")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Text("BYN \(cartViewModel.totalPrice + 2.0, specifier: "%.2f")")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.orange)
                                }
                            }
                            .padding()
                            .background(Color.black)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.orange, lineWidth: 1)
                            )
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                    }
                    
                    Button(action: {
                        // Подтверждение заказа
                        placeOrder()
                    }) {
                        Text("Place Order")
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
            }
            .navigationBarHidden(true)
        }
    }
    
    private func placeOrder() {
        guard !deliveryAddress.isEmpty else {
            // Показать ошибку: адрес обязателен
            return
        }
        
        // Здесь будет логика создания заказа
        print("Order placed to: \(deliveryAddress)")
        cartViewModel.clearCart()
        presentationMode.wrappedValue.dismiss()
    }
}
