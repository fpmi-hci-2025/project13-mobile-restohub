import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var nickname = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var selectedLanguage = "English"
    @State private var showingCustomMenu = false
    
    // Выбор способа регистрации: email или phone
    @State private var registrationMethod: RegistrationMethod = .email
    
    enum RegistrationMethod {
        case email
        case phone
    }
    
    // Состояния для отслеживания фокуса на полях
    @FocusState private var focusedField: Field?
    
    enum Field {
        case firstName, lastName, nickname, email, phone, password, confirmPassword
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // ЧЕРНЫЙ ФОН
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Навигационная панель - ЧЕРНАЯ
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
                        
                        Text("Sign Up")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        // Кнопка смены языка - ОРАНЖЕВАЯ
                        Button(action: {
                            showingCustomMenu = true
                        }) {
                            HStack(spacing: 6) {
                                Text(selectedLanguage)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.black)
                                
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color.orange)
                            .cornerRadius(6)
                        }
                        .padding(.trailing, 16)
                    }
                    .frame(height: 60)
                    .background(Color.black)
                    
                    // Основной контент
                    ScrollView {
                        VStack(spacing: 30) {
                            // Логотип - ОРАНЖЕВЫЙ
                            VStack(spacing: 8) {
                                Text("RestoHUB")
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(.orange)
                                
                                Text("Welcome to RestoHUB")
                                    .font(.system(size: 16))
                                    .foregroundColor(.orange.opacity(0.9))
                            }
                            .padding(.top, 40)
                            
                            // Переключатель способа регистрации
                            HStack(spacing: 0) {
                                Button(action: {
                                    withAnimation {
                                        registrationMethod = .email
                                    }
                                }) {
                                    VStack(spacing: 8) {
                                        Text("Email")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(registrationMethod == .email ? .white : .white.opacity(0.6))
                                        
                                        Rectangle()
                                            .frame(height: 2)
                                            .foregroundColor(registrationMethod == .email ? .orange : .clear)
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                
                                Button(action: {
                                    withAnimation {
                                        registrationMethod = .phone
                                    }
                                }) {
                                    VStack(spacing: 8) {
                                        Text("Phone")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(registrationMethod == .phone ? .white : .white.opacity(0.6))
                                        
                                        Rectangle()
                                            .frame(height: 2)
                                            .foregroundColor(registrationMethod == .phone ? .orange : .clear)
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.bottom, 10)
                            
                            // Поля формы
                            VStack(spacing: 16) {
                                CustomTextField(
                                    title: "FIRST NAME",
                                    text: $firstName,
                                    placeholder: "John",
                                    isFocused: focusedField == .firstName,
                                    field: .firstName,
                                    focusedField: $focusedField
                                )
                                
                                CustomTextField(
                                    title: "LAST NAME",
                                    text: $lastName,
                                    placeholder: "Doe",
                                    isFocused: focusedField == .lastName,
                                    field: .lastName,
                                    focusedField: $focusedField
                                )
                                
                                CustomTextField(
                                    title: "NICKNAME",
                                    text: $nickname,
                                    placeholder: "restohub_lover",
                                    isFocused: focusedField == .nickname,
                                    field: .nickname,
                                    focusedField: $focusedField
                                )
                                
                                // Поле для email или phone в зависимости от выбора
                                if registrationMethod == .email {
                                    CustomTextField(
                                        title: "EMAIL",
                                        text: $email,
                                        placeholder: "you@example.com",
                                        keyboardType: .emailAddress,
                                        isFocused: focusedField == .email,
                                        field: .email,
                                        focusedField: $focusedField
                                    )
                                } else {
                                    CustomTextField(
                                        title: "PHONE",
                                        text: $phone,
                                        placeholder: "+375 29 123-45-67",
                                        keyboardType: .phonePad,
                                        isFocused: focusedField == .phone,
                                        field: .phone,
                                        focusedField: $focusedField
                                    )
                                }
                                
                                CustomSecureField(
                                    title: "PASSWORD",
                                    text: $password,
                                    placeholder: "Create a password",
                                    isFocused: focusedField == .password,
                                    field: .password,
                                    focusedField: $focusedField
                                )
                                
                                CustomSecureField(
                                    title: "CONFIRM PASSWORD",
                                    text: $confirmPassword,
                                    placeholder: "Confirm your password",
                                    isFocused: focusedField == .confirmPassword,
                                    field: .confirmPassword,
                                    focusedField: $focusedField
                                )
                            }
                            .padding(.horizontal, 24)
                            
                            // Кнопка создания аккаунта - ОРАНЖЕВАЯ
                            Button(action: {
                                userViewModel.signUp(
                                    firstName: firstName,
                                    lastName: lastName,
                                    nickname: nickname,
                                    email: registrationMethod == .email ? email : nil,
                                    phone: registrationMethod == .phone ? phone : nil,
                                    password: password
                                )
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Create account")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 18)
                                    .background(Color.orange)
                                    .cornerRadius(12)
                            }
                            .padding(.horizontal, 24)
                            .shadow(color: Color.orange.opacity(0.5), radius: 10, x: 0, y: 5)
                            
                            // Ссылка на вход
                            HStack {
                                Text("Already have an account?")
                                    .font(.system(size: 14))
                                    .foregroundColor(.orange)
                                
                                Button("Sign in") {
                                    presentationMode.wrappedValue.dismiss()
                                }
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.orange)
                            }
                            .padding(.top, 20)
                            
                            Spacer()
                                .frame(height: 50)
                        }
                    }
                    .background(Color.black)
                }
                .navigationBarHidden(true)
                .background(Color.black)
                
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
        .animation(.spring(response: 0.3), value: showingCustomMenu)
    }
}

struct CustomTextField: View {
    let title: String
    @Binding var text: String
    var placeholder: String = ""
    var keyboardType: UIKeyboardType = .default
    var isFocused: Bool
    var field: SignUpView.Field
    @FocusState.Binding var focusedField: SignUpView.Field?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.orange)
            
            ZStack(alignment: .leading) {
                TextField("", text: $text)
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.orange, lineWidth: 1)
                    )
                    .focused($focusedField, equals: field)
                    .onTapGesture {
                        focusedField = field
                    }
                
                // БЕЛЫЙ пример ввода (показывается только когда поле пустое и не в фокусе)
                if text.isEmpty && !isFocused {
                    Text(placeholder)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.horizontal, 16)
                        .allowsHitTesting(false)
                        .onTapGesture {
                            focusedField = field
                        }
                }
            }
        }
    }
}

struct CustomSecureField: View {
    let title: String
    @Binding var text: String
    var placeholder: String = ""
    var isFocused: Bool
    var field: SignUpView.Field
    @FocusState.Binding var focusedField: SignUpView.Field?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.orange)
            
            ZStack(alignment: .leading) {
                SecureField("", text: $text)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.orange, lineWidth: 1)
                    )
                    .focused($focusedField, equals: field)
                    .onTapGesture {
                        focusedField = field
                    }
                
                // БЕЛЫЙ пример ввода для пароля (показывается только когда поле пустое и не в фокусе)
                if text.isEmpty && !isFocused {
                    Text(placeholder)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.horizontal, 16)
                        .allowsHitTesting(false)
                        .onTapGesture {
                            focusedField = field
                        }
                }
            }
        }
    }
}
