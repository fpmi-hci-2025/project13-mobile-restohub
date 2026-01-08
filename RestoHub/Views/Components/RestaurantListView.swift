// Views/Components/RestaurantsListView.swift
import SwiftUI

struct RestaurantsListView: View {
    @EnvironmentObject var restaurantViewModel: RestaurantViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(restaurantViewModel.filteredRestaurants) { restaurant in
                NavigationLink(
                    destination: RestaurantDetailView(restaurant: restaurant)
                ) {
                    RestaurantCard(restaurant: restaurant)
                }
            }
        }
    }
}
