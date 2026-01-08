import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var showingSignIn = false
    @State private var showingSignUp = false
    @State private var selectedLanguage = "English"
    @State private var showingCustomMenu = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Основной контент
                VStack(spacing: 0) {
                    // Верхняя панель - RestoHub
                    HStack {
                        Text("RestoHub")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.leading, 16)
                        
                        Spacer()
                        
                        Spacer()
                            .frame(width: 60)
                    }
                    .frame(height: 60)
                    .background(Color.black)
                    
                    // Кнопка смены языка по правому краю
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            showingCustomMenu = true
                        }) {
                            HStack(spacing: 6) {
                                Text(selectedLanguage)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.orange)
                            .cornerRadius(8)
                        }
                        .padding(.trailing, 16)
                    }
                    .frame(height: 40)
                    .background(Color.black)
                    
                    // Основной контент
                    ScrollView {
                        VStack(spacing: 40) {
                            // ФОТО
                            ZStack {
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 220, height: 220)
                                    .shadow(color: Color.white.opacity(0.2), radius: 20, x: 0, y: 10)
                                
                                Image("app-logo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .clipShape(Circle())
                                
                                Circle()
                                    .stroke(Color.orange, lineWidth: 4)
                                    .frame(width: 220, height: 220)
                            }
                            .shadow(color: Color.white.opacity(0.2), radius: 10, x: 0, y: 5)
                            
                            // Заголовок
                            VStack(spacing: 24) {
                                Text("Welcome to RestoHub")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                
                                Text("RestoHub is a modern food delivery and restaurant discovery platform. Explore a curated network of cafes and restaurants, browse menus in a few taps, build your favourite orders, and track deliveries in real time.")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white.opacity(0.9))
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(6)
                                    .padding(.horizontal, 24)
                            }
                            
                            // Главная кнопка
                            Button(action: {
                                showingSignIn = true
                            }) {
                                Text("START EXPLORING RESTAURANTS")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 18)
                                    .background(Color.orange)
                                    .cornerRadius(12)
                            }
                            .padding(.horizontal, 24)
                            .shadow(color: Color.orange.opacity(0.3), radius: 10, x: 0, y: 5)
                            
                            // Кнопки Sign In и Sign Up
                            HStack(spacing: 20) {
                                Button("Sign In") {
                                    showingSignIn = true
                                }
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                
                                Circle()
                                    .frame(width: 4, height: 4)
                                    .foregroundColor(.white.opacity(0.7))
                                
                                Button("Sign Up") {
                                    showingSignUp = true
                                }
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                            }
                            .padding(.top, 20)
                            .padding(.bottom, 40)
                        }
                        .padding(.vertical, 20)
                    }
                    .background(Color.black)
                }
                .navigationBarHidden(true)
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
                
                // Кастомное меню выбора языка с ЧЕРНЫМ фоном
                if showingCustomMenu {
                    Color.black.opacity(0.7)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            showingCustomMenu = false
                        }
                    
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Button(action: {
                                selectedLanguage = "English"
                                showingCustomMenu = false
                            }) {
                                HStack {
                                    Text("English")
                                        .font(.system(size: 14))
                                        .foregroundColor(.orange)
                                    
                                    Spacer()
                                    
                                    if selectedLanguage == "English" {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.orange)
                                            .font(.system(size: 12))
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.black)
                            }
                            
                            Divider()
                                .background(Color.orange.opacity(0.3))
                                .padding(.horizontal, 16)
                            
                            Button(action: {
                                selectedLanguage = "Русский"
                                showingCustomMenu = false
                            }) {
                                HStack {
                                    Text("Русский")
                                        .font(.system(size: 14))
                                        .foregroundColor(.orange)
                                    
                                    Spacer()
                                    
                                    if selectedLanguage == "Русский" {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.orange)
                                            .font(.system(size: 12))
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.black)
                            }
                        }
                        .background(Color.black)
                    }
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.orange, lineWidth: 1)
                    )
                    .frame(width: 180)
                    .shadow(color: Color.orange.opacity(0.3), radius: 15, x: 0, y: 8)
                    .position(x: UIScreen.main.bounds.width - 110, y: 100)
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(1000)
                }
            }
        }
        .fullScreenCover(isPresented: $showingSignIn) {
            SignInView()
        }
        .fullScreenCover(isPresented: $showingSignUp) {
            SignUpView()
        }
        .animation(.spring(response: 0.3), value: showingCustomMenu)
    }
}
