//
//  AppViewModel.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//
import SwiftUI


protocol AppViewInteractor {
    var showTabBar: Bool { get }
}

extension CoreInteractor: AppViewInteractor {}

@MainActor
@Observable
class AppViewModel {
    let interactor: AppViewInteractor
    
    init(interactor: AppViewInteractor) {
        self.interactor = interactor
    }
}
