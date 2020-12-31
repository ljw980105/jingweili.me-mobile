//
//  LoginViewModel.swift
//  jingweili.me-mobile
//
//  Created by Jing Wei Li on 9/21/20.
//

import Foundation
import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    @State var readyToLogin: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    func login(with password: String, completed: @escaping () -> Void) {
        PersonalWebsiteAPI
            .loginWith(passcode: password)
            .sink(receiveCompletion: { status in
                if case .failure(let error) = status {
                    print(error.localizedDescription)
                }
            }, receiveValue: { token in
                print(token.token)
                SessionToken.set(token: token.token)
                completed()
            })
            .store(in: &cancellables)
    }
    
    func logout() {
        PersonalWebsiteAPI
            .logOut()
            .sink(receiveCompletion: { _ in  }) { _ in
                print("logged out")
            }
            .store(in: &cancellables)
    }
}
