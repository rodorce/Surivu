//
//  LogInView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//

import SwiftUI

struct LogInView: View {
    @State var viewModel: LoginViewModel
    var body: some View {
            ZStack {
                Color.accent
                VStack(alignment: .center) {
                    Image("AppIconInternal")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 200, height: 200)
                    TextField("Username", text: $viewModel.username)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 8)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 8)
                    Button {
                        viewModel.signIn()
                    } label: {
                        Text("Log In")
                            .foregroundStyle(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.vertical, 10)
                }
            }
            .ignoresSafeArea()
    }
}

#Preview {
    let container = DevPreview.shared.container
    LogInView(viewModel: LoginViewModel(interactor: CoreInteractor(container: container)))
}
