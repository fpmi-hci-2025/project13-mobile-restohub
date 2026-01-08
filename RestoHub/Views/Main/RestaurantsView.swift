// Views/Main/RestaurantsView.swift
import SwiftUI

struct RestaurantsView: View {
    @EnvironmentObject var restaurantViewModel: RestaurantViewModel
    @State private var searchText = ""
    @State private var selectedCategory = "Pizza"
    
    let categories = ["Pizza", "Sushi", "Burgers", "Shields"]
    
    var body: some View {
        NavigationView {
            ZStack {
                // ЧЕРНЫЙ ФОН
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Навигационная панель
                    NavigationHeaderView()
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            // Поиск
                            SearchBarView(searchText: $searchText) {
                                restaurantViewModel.searchRestaurants(query: searchText)
                            }
                            .padding(.horizontal, 24)
                            .padding(.top, 20)
                            
                            // Категории
                            CategoriesView(
                                categories: categories,
                                selectedCategory: $selectedCategory
                            ) { category in
                                restaurantViewModel.filterRestaurants(by: category)
                            }
                            .padding(.horizontal, 4)
                            
                            // Разделительная линия
                            Divider()
                                .background(Color.orange.opacity(0.5))
                                .padding(.horizontal, 24)
                                .padding(.vertical, 8)
                            
                            // Список ресторанов
                            RestaurantsListView()
                                .padding(.horizontal, 24)
                                .padding(.top, 10)
                            
                            Spacer()
                                .frame(height: 30)
                        }
                    }
                    .background(Color.black)
                }
                .navigationBarHidden(true)
            }
        }
        .accentColor(.orange)
    }
}

struct RestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantsView()
            .environmentObject(RestaurantViewModel())
            .preferredColorScheme(.dark)
    }
}
