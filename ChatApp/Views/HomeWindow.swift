//
//  HomeWindow.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 15.03.2022.
//

import SwiftUI

struct HomeWindow: View {
    @State private var showBackground = false
    @State private var authenticator: String = ""
    
    @State private var showLogIn = false
    @State private var showSignUp = false
    
    @State private var showButtons = false
    @ObservedObject var auth: Authentication
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                NavigationView{
                    ZStack{
                        Background(showBackground: $showBackground,
                                   parallelogramFrameHeight: 390,
                                   sectionAngle: 45,
                                   screenWidth: 390,
                                   screenHeight: 844)
                        
                        VStack (alignment: .center, spacing: 8) {
                            FieldWithImage(imageName: "person", fieldName: "Username", textValue: $authenticator)
                            FieldWithImage(imageName: "person", fieldName: "Password", textValue: $authenticator)
                            
                            Button("Log In") {
                                withAnimation {
                                    showButtons = false
                                }
                                showBackground = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        isLoggedIn = true
                                    }
                                }
                            }

                            NavigationLink(isActive: $showSignUp) {
                                SignUp()
                            } label: {
                                Button("Sign Up") {
                                    showBackground = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        showSignUp = true
                                    }
                                }
                            }
                        }
                        .buttonStyle(CustomButtonStyle())
                        .padding(12)
                        .opacity(showButtons ? 1 : 0)
                        .onAppear {
                            DispatchQueue.main.async {
                                withAnimation(.easeInOut(duration: 1).delay(2)) {
                                    showButtons = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct HomeWindow_Previews: PreviewProvider {
    static var previews: some View {
        HomeWindow(auth: Authentication(), isLoggedIn: .constant(false))
    }
}
