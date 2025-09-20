//
//  LogInViewModel.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//
import SwiftUI

protocol LoginInteractor {
    var showTabBar: Bool { get }
    func signInMangadex(username: String, password: String) async throws
    func logOutMangadex()
    func updateAppState(showTabBarView: Bool)
}

extension CoreInteractor: LoginInteractor {}

@MainActor
@Observable
class LoginViewModel {
    let interactor: LoginInteractor
    var username: String = ""
    var password: String = ""
    var path: [AuthPathOption] = []
    
    init(interactor: LoginInteractor) {
        self.interactor = interactor
    }
    
    var showTabBar: Bool {
        interactor.showTabBar
    }
    
    func signIn() {
        Task {
            do {
                try await interactor.signInMangadex(username: username, password: password)
                interactor.updateAppState(showTabBarView: true)
            } catch {
                print("Error: Could not sign in. \(error)")
            }
        }
    }
}
