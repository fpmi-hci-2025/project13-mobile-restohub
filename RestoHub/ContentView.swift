import SwiftUI

struct ContentView: View {
    @StateObject private var tabManager = TabManager()
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        TabView(selection: $tabManager.selectedTab) {
            RestaurantsView()
                .tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Restaurants")
                    }
                }
                .tag(0)
            
            CartView()
                .tabItem {
                    VStack {
                        Image(systemName: "cart.fill")
                        Text("Cart")
                    }
                }
                .tag(1)
            
            OrdersView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Orders")
                    }
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                }
                .tag(3)
        }
        .accentColor(.orange)
        .environmentObject(tabManager)
        .onReceive(tabManager.tabChanged) { tab in
            tabManager.selectedTab = tab
        }
    }
}
