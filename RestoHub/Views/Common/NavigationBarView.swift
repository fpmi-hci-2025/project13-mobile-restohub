//import SwiftUI
//
//struct NavigationBarView: View {
//    let title: String
//    let showBackButton: Bool
//    let trailingButtons: Bool
//    @State private var selectedLanguage = "English"
//    
//    var body: some View {
//        HStack {
//            if showBackButton {
//                Button(action: {}) {
//                    Image(systemName: "chevron.left")
//                        .font(.system(size: 20, weight: .medium))
//                        .foregroundColor(.white)
//                }
//                .padding(.leading, 16)
//            } else {
//                Spacer()
//                    .frame(width: 40)
//            }
//            
//            Spacer()
//            
//            Text(title)
//                .font(.system(size: 18, weight: .semibold))
//                .foregroundColor(.white)
//            
//            Spacer()
//            
//            if trailingButtons {
//                HStack(spacing: 12) {
//                    Menu {
//                        Button("English") { selectedLanguage = "English" }
//                        Button("Русский") { selectedLanguage = "Русский" }
//                        Button("Беларуская") { selectedLanguage = "Беларуская" }
//                    } label: {
//                        HStack(spacing: 4) {
//                            Text(selectedLanguage)
//                                .font(.system(size: 12, weight: .medium))
//                                .foregroundColor(Color("PrimaryOrange"))
//                            
//                            Image(systemName: "chevron.down")
//                                .font(.system(size: 10, weight: .medium))
//                                .foregroundColor(Color("PrimaryOrange"))
//                        }
//                    }
//                    
//                    Circle()
//                        .frame(width: 4, height: 4)
//                        .foregroundColor(Color("PrimaryOrange"))
//                    
//                    Button("Sign In") {}
//                        .font(.system(size: 12, weight: .medium))
//                        .foregroundColor(Color("PrimaryOrange"))
//                    
//                    Circle()
//                        .frame(width: 4, height: 4)
//                        .foregroundColor(Color("PrimaryOrange"))
//                    
//                    Button("Sign up") {}
//                        .font(.system(size: 12, weight: .medium))
//                        .foregroundColor(Color("PrimaryOrange"))
//                }
//                .padding(.trailing, 16)
//            } else {
//                Spacer()
//                    .frame(width: 40)
//            }
//        }
//        .frame(height: 60)
//        .background(Color.black)
//    }
//}

// Views/Common/NavigationBarView.swift
import SwiftUI

struct NavigationBarView: View {
    let title: String
    let showBackButton: Bool
    let trailingButtons: Bool
    
    var body: some View {
        HStack {
            if showBackButton {
                Button(action: {
                    // Действие для кнопки назад
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                }
                .padding(.leading, 16)
            } else {
                Spacer()
                    .frame(width: 40)
            }
            
            Spacer()
            
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
            
            Spacer()
            
            if trailingButtons {
                HStack(spacing: 16) {
                    Button(action: {
                        // Действие для корзины
                    }) {
                        Image(systemName: "cart")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        // Действие для заказов
                    }) {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
                .padding(.trailing, 16)
            } else {
                Spacer()
                    .frame(width: 40)
            }
        }
        .frame(height: 60)
        .background(Color.black)
    }
}
