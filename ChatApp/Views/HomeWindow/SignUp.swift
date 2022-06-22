//
//  SignUp.swift
//  ChatApp
//
//  Created by Dima Kryshtal on 11.03.2022.
//

import SwiftUI
import Combine

struct SignUp: View {
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        ZStack{
            Color.blue.opacity(0.03)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 15) {
                HStack(alignment: .center, spacing: 10) {
                    FieldWithImage(imageName: nil, fieldName: "First Name", lineWidth: 3, textValue: $viewModel.firstName)
                    FieldWithImage(imageName: nil, fieldName: "Last Name", lineWidth: 3, textValue: $viewModel.lastName)
                }
                .frame(height: 60)
                
                FieldWithImage(imageName: "person", fieldName: "Username", lineWidth: 3, textValue: $viewModel.authenticator)
                    .frame(height: 60)
                FieldWithImage(imageName: "envelope", fieldName: "E-mail", lineWidth: 3, textValue: $viewModel.email)
                    .frame(height: 60)
                SecretFieldWithImage(fieldName: "Password", textValue: $viewModel.password)
                    .frame(height: 60)
                
                Button("Sign Up") {
                    let user = User(firstName: viewModel.firstName,
                                    lastName: viewModel.lastName,
                                    username: viewModel.authenticator,
                                    email: viewModel.email,
                                    password: viewModel.password,
                                    userChats: [],
                                    userFriends: [])
                    print("\n\n\n \(user)")
                    viewModel.sendNewUser(user: user)
                    
                }
                .buttonStyle(CustomButtonStyle())
                .alert("User already exists.", isPresented: $viewModel.showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            .padding()
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
