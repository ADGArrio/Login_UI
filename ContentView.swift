import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = false
    @State private var wrongPassword = false
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.green.opacity(0.25)
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.green.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                VStack {
                    Text("X-RAI")
                        .font(Font.custom("Source Sans Pro", size: 80))
                        .bold()
                        .foregroundColor(Color.green.opacity(0.9))
                        .padding()
                    Text("Login")
                        .font(.title)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.green.opacity(0.05))
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(wrongUsername ? Color.red : Color.clear, lineWidth: 2))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.green.opacity(0.05))
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(wrongPassword ? Color.red : Color.clear, lineWidth: 2))
                    
                    Button("Login") {
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                }
            }
            .navigationBarHidden(true)
            .background(
                NavigationLink(
                    destination: UploadScreen(),
                    isActive: $showingLoginScreen
                ) {
                    EmptyView()
                }
            )
        }
    }
    
    func authenticateUser(username: String, password: String) {
        if username.lowercased() == "arrio" {
            wrongUsername = false
            if password.lowercased() == "abc123" {
                wrongPassword = false
                showingLoginScreen = true
            } else {
                wrongPassword = true
            }
        } else {
            wrongUsername = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
