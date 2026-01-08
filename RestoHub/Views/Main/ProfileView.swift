//import SwiftUI
//
//struct ProfileView: View {
//    @EnvironmentObject var userViewModel: UserViewModel
//    @State private var showingSignOutAlert = false
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            NavigationBarView(
//                title: "Profile",
//                showBackButton: false,
//                trailingButtons: true
//            )
//            
//            ScrollView {
//                VStack(spacing: 0) {
//                    // Информация о пользователе
//                    VStack(alignment: .leading, spacing: 12) {
//                        HStack {
//                            VStack(alignment: .leading, spacing: 4) {
//                                Text(userViewModel.currentUser?.nickname ?? "restohub_lover")
//                                    .font(.system(size: 24, weight: .semibold))
//                                
//                                Text(userViewModel.currentUser?.email ?? "anna@example.com")
//                                    .font(.system(size: 14))
//                                    .foregroundColor(.gray)
//                            }
//                            
//                            Spacer()
//                        }
//                    }
//                    .padding(16)
//                    
//                    Divider()
//                        .padding(.horizontal, 16)
//                    
//                    // Разделы профиля
//                    VStack(spacing: 0) {
//                        ProfileSection(
//                            title: "Addresses",
//                            subtitle: "2 addresses saved"
//                        ) {}
//                        
//                        Divider()
//                            .padding(.leading, 56)
//                        
//                        ProfileSection(
//                            title: "Payment methods",
//                            subtitle: userViewModel.hasPaymentMethods ? "1 card saved" : "No cards added"
//                        ) {}
//                        
//                        Divider()
//                            .padding(.leading, 56)
//                        
//                        ProfileSection(
//                            title: "Discounts",
//                            subtitle: "Promocodes and coupons (soon)"
//                        ) {}
//                        
//                        Divider()
//                            .padding(.leading, 56)
//                        
//                        ProfileSection(
//                            title: "Help",
//                            subtitle: "FAQ and chat (soon)"
//                        ) {}
//                        
//                        Divider()
//                            .padding(.leading, 56)
//                        
//                        // Кнопка выхода
//                        Button(action: {
//                            showingSignOutAlert = true
//                        }) {
//                            HStack(spacing: 16) {
//                                Image(systemName: "rectangle.portrait.and.arrow.right")
//                                    .font(.system(size: 16))
//                                    .foregroundColor(.red)
//                                
//                                Text("Sign out")
//                                    .font(.system(size: 16, weight: .medium))
//                                    .foregroundColor(.red)
//                                
//                                Spacer()
//                            }
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 12)
//                        }
//                    }
//                    .padding(.vertical, 8)
//                }
//            }
//        }
//        .background(Color(.systemBackground))
//        .alert(isPresented: $showingSignOutAlert) {
//            Alert(
//                title: Text("Sign Out"),
//                message: Text("Are you sure you want to sign out?"),
//                primaryButton: .destructive(Text("Sign Out")) {
//                    userViewModel.signOut()
//                },
//                secondaryButton: .cancel()
//            )
//        }
//    }
//}
//struct ProfileSection: View {
//    let title: String
//    let subtitle: String
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            HStack(spacing: 16) {
//                VStack(alignment: .leading, spacing: 2) {
//                    Text(title)
//                        .font(.system(size: 16, weight: .medium))
//                        .foregroundColor(.primary)
//                    
//                    Text(subtitle)
//                        .font(.system(size: 14))
//                        .foregroundColor(.gray)
//                }
//                
//                Spacer()
//                
//                Image(systemName: "chevron.right")
//                    .font(.system(size: 14))
//                    .foregroundColor(.gray)
//            }
//            .padding(.horizontal, 16)
//            .padding(.vertical, 12)
//            .contentShape(Rectangle())
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}
import SwiftUI

struct ProfileView: View {
    // Add @State variables for toggles
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    @State private var locationEnabled = true
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Profile")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
                
                // Profile icon or avatar
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.orange)
            }
            .frame(height: 60)
            .padding(.horizontal)
            .background(Color.black)
            
            ScrollView {
                VStack(spacing: 0) {
                    // User info section
                    VStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                        
                        Text("John Doe")
                            .font(.system(size: 20, weight: .semibold))
                        
                        Text("john.doe@example.com")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 32)
                    
                    // Settings section
                    VStack(spacing: 0) {
                        SettingsMenuItem(
                            icon: "bell",
                            title: "Notifications",
                            hasToggle: true,
                            isOn: $notificationsEnabled
                        )
                        
                        Divider()
                            .padding(.leading, 50)
                        
                        SettingsMenuItem(
                            icon: "moon",
                            title: "Dark Mode",
                            hasToggle: true,
                            isOn: $darkModeEnabled
                        )
                        
                        Divider()
                            .padding(.leading, 50)
                        
                        SettingsMenuItem(
                            icon: "location",
                            title: "Location Services",
                            hasToggle: true,
                            isOn: $locationEnabled
                        )
                        
                        Divider()
                            .padding(.leading, 50)
                        
                        SettingsMenuItem(
                            icon: "lock",
                            title: "Privacy & Security",
                            hasToggle: false
                        )
                        
                        Divider()
                            .padding(.leading, 50)
                        
                        SettingsMenuItem(
                            icon: "questionmark.circle",
                            title: "Help & Support",
                            hasToggle: false
                        )
                        
                        Divider()
                            .padding(.leading, 50)
                        
                        SettingsMenuItem(
                            icon: "arrow.right.square",
                            title: "Logout",
                            hasToggle: false,
                            isDestructive: true
                        )
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.top)
                }
            }
        }
        .background(Color(.systemGray6))
    }
}

struct SettingsMenuItem: View {
    let icon: String
    let title: String
    let hasToggle: Bool
    var isOn: Binding<Bool>? = nil
    var isDestructive: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 24)
                .foregroundColor(isDestructive ? .red : .gray)
            
            Text(title)
                .foregroundColor(isDestructive ? .red : .black)
            
            Spacer()
            
            if hasToggle, let isOnBinding = isOn {
                Toggle("", isOn: isOnBinding)
                    .labelsHidden()
                    .tint(.orange)
            } else {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 16)
        .contentShape(Rectangle())
    }
}

// Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
