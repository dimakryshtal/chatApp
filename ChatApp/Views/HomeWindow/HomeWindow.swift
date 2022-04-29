//
//  HomeWindow.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 15.03.2022.
//

import SwiftUI

struct HomeWindow: View {
//    @EnvironmentObject var authentication: Authentication
    @ObservedObject var viewModel: HomeWindowViewModel
    @State private var showingSheet = false
    @State private var showAuthInterface = true
    
    var body: some View {
            ZStack (alignment: .top){
                Background(showBackground: $viewModel.showBackground,
                           parallelogramFrameHeight: 390,
                           sectionAngle: 45,
                           screenWidth: 390,
                           screenHeight: 844)
                
                
                VStack (alignment: .center, spacing: 8) {
                    CircleImage(image: !showAuthInterface ? Image("kitty") : Image(""))
                        .frame(width: 250, height: 250)
                        .padding(.bottom, 20)
                    
                    if (showAuthInterface) {
                        FieldWithImage(imageName: "person", fieldName: "Username", textValue: $viewModel.authenticator)
                            .frame(height: 60)
                        FieldWithImage(imageName: "lock", fieldName: "Password", textValue: $viewModel.password)
                            .frame(height: 60)
                        
                        Button("Log In") {
                            viewModel.logIn()
                        }
                        .alert("User does not exist", isPresented: $viewModel.showingAlert) {
                            Button("OK", role: .cancel) { }
                        }
                        
                        Button("Sign Up") {
                            showingSheet.toggle()
                        }
                        .sheet(isPresented: $showingSheet) {
                            SignUp()
                        }
                    } else {
                        Button("Continue") {
                            viewModel.successfullLogin()
                            viewModel.hideHomeWindow()
                        }
                    }
                }
                .buttonStyle(CustomButtonStyle())
                .padding(12)
                .opacity(viewModel.showButtons ? 1 : 0)
                .onAppear {
                    viewModel.showInterfaceButtons()
                    showAuthInterface = !viewModel.authentication.isLoggedIn
                }
            }

    }
}

struct HomeWindow_Previews: PreviewProvider {
    static var previews: some View {
        HomeWindow(viewModel: HomeWindowViewModel(auth: Authentication()))
//            .environmentObject(Authentication())
    }
}



