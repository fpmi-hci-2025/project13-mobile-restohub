//import SwiftUI
//
//struct RestaurantDetailView: View {
//    let restaurant: Restaurant
//    @EnvironmentObject var cartViewModel: CartViewModel  // ← работает если CartViewModel - ObservableObject
//    @Environment(\.presentationMode) var presentationMode
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            NavigationBarView(
//                title: restaurant.name,
//                showBackButton: true,
//                trailingButtons: true
//            )
//            
//            // Категории меню
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 16) {
//                    Text("Домстер")
//                    Text("Пицца")
//                    Text("Пицца от Шефа")
//                }
//                .padding(.horizontal)
//            }
//            
//            // Список блюд
//            ScrollView {
//                LazyVStack(spacing: 16) {
//                    ForEach(MenuItem.dominoMenu) { item in
//                        MenuItemCard(item: item) {
//                            cartViewModel.addToCart(
//                                menuItem: item,
//                                restaurantName: restaurant.name
//                            )
//                        }
//                        .padding(.horizontal)
//                    }
//                }
//                .padding(.vertical)
//            }
//            
//            Spacer()
//            
//        }
//        .navigationBarHidden(true)
//    }
//}

// Vieimport SwiftUI
import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    @EnvironmentObject var cartViewModel: CartViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedCategory = "Popular"
    
    let categories = ["Popular", "Burgers", "Pizza", "Drinks", "Desserts"]
    
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
                        
                        Text(restaurant.name)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Spacer()
                            .frame(width: 40)
                    }
                    .frame(height: 60)
                    .background(Color.black)
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            // Изображение ресторана
                            Image(systemName: "building.2.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .foregroundColor(.orange)
                                .padding(.top, 20)
                            
                            // Информация о ресторане
                            VStack(spacing: 12) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(restaurant.name)
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundColor(.white)
                                        
                                        HStack(spacing: 12) {
                                            HStack(spacing: 4) {
                                                Image(systemName: "star.fill")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.orange)
                                                
                                                Text("\(restaurant.rating, specifier: "%.1f")")
                                                    .font(.system(size: 14, weight: .medium))
                                                    .foregroundColor(.white)
                                            }
                                            
                                            Text("•")
                                                .foregroundColor(.orange)
                                            
                                            Text(restaurant.deliveryTime)
                                                .font(.system(size: 14))
                                                .foregroundColor(.white.opacity(0.8))
                                            
                                            Text("•")
                                                .foregroundColor(.orange)
                                            
                                            Text(restaurant.deliveryCost)
                                                .font(.system(size: 14))
                                                .foregroundColor(.white.opacity(0.8))
                                        }
                                    }
                                    
                                    Spacer()
                                }
                                
                                Text(restaurant.description)
                                    .font(.system(size: 14))
                                    .foregroundColor(.white.opacity(0.9))
                                    .lineSpacing(4)
                            }
                            .padding(.horizontal)
                            
                            // Категории меню
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(categories, id: \.self) { category in
                                        Button(action: {
                                            selectedCategory = category
                                        }) {
                                            Text(category)
                                                .font(.system(size: 14, weight: selectedCategory == category ? .semibold : .regular))
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 8)
                                                .background(selectedCategory == category ? Color.orange : Color.gray.opacity(0.2))
                                                .foregroundColor(selectedCategory == category ? .white : .white.opacity(0.9))
                                                .cornerRadius(20)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            // Меню
                            VStack(spacing: 16) {
                                ForEach(mockMenuItems) { item in
                                    MenuItemCard(item: item) {
                                        // Исправленный вызов с передачей restaurantId и restaurantName
                                        cartViewModel.addItem(
                                            item,
                                            restaurantId: restaurant.id,
                                            restaurantName: restaurant.name
                                        )
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.top, 10)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private var mockMenuItems: [MenuItem] {
        return [
            MenuItem(
                id: "1",
                name: "Cheeseburger",
                description: "Juicy beef patty with cheese",
                price: 5.99,
                imageUrl: "cheeseburger",
                category: "Burgers",
                restaurantId: restaurant.id,
                isAvailable: true
            ),
            MenuItem(
                id: "2",
                name: "Pepperoni Pizza",
                description: "Classic pizza with pepperoni",
                price: 12.99,
                imageUrl: "pepperoni_pizza",
                category: "Pizza",
                restaurantId: restaurant.id,
                isAvailable: true
            ),
            MenuItem(
                id: "3",
                name: "Caesar Salad",
                description: "Fresh salad with Caesar dressing",
                price: 7.99,
                imageUrl: "caesar_salad",
                category: "Salads",
                restaurantId: restaurant.id,
                isAvailable: true
            )
        ]
    }
}
