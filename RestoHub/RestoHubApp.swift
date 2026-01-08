import SwiftUI

@main
struct RestoHubApp: App {
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var cartViewModel = CartViewModel()
    @StateObject private var restaurantViewModel = RestaurantViewModel()
    @StateObject private var ordersViewModel = OrdersViewModel()
    
    var body: some Scene {
        WindowGroup {
            if userViewModel.isAuthenticated {
                ContentView()
                    .environmentObject(userViewModel)
                    .environmentObject(cartViewModel)
                    .environmentObject(restaurantViewModel)
                    .environmentObject(ordersViewModel)
                    .preferredColorScheme(.dark)
            } else {
                WelcomeView()
                    .environmentObject(userViewModel)
                    .environmentObject(cartViewModel)
                    .environmentObject(restaurantViewModel)
                    .environmentObject(ordersViewModel)
                    .preferredColorScheme(.dark)
            }
        }
    }
}
