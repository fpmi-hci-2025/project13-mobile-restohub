// Views/Components/SearchBarView.swift
import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var onSearchChanged: (() -> Void)?
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Search dishes and restaurants")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.orange)
            
            ZStack(alignment: .leading) {
                TextField("", text: $searchText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSearchFocused ? Color.orange : Color.orange.opacity(0.7), lineWidth: isSearchFocused ? 2 : 1.5)
                    )
                    .focused($isSearchFocused)
                    .onChange(of: searchText) { _ in
                        onSearchChanged?()
                    }
                    .submitLabel(.search)
                
                // Показываем луп только когда поле пустое И не в фокусе
                if searchText.isEmpty && !isSearchFocused {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.orange)
                            .padding(.leading, 12)
                        
                        Text("Search dishes and restaurants")
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.leading, 4)
                    }
                    .allowsHitTesting(false)
                    .onTapGesture {
                        isSearchFocused = true
                    }
                } else if !isSearchFocused {
                    // Показываем только луп, когда есть текст, но не в фокусе
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.orange)
                            .padding(.leading, 12)
                        Spacer()
                    }
                }
            }
        }
    }
}
