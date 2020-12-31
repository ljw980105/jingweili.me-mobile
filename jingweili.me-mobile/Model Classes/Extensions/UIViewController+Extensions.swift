//
//  UIViewController+Extensions.swift
//  jingweili.me-mobile
//
//  Created by Jing Wei Li on 12/30/20.
//

import Foundation
import UIKit
import Combine

extension UIViewController {
    /// Note: The added view is centered, occupying full screen
    func showViewWithConstraints(controller: UIViewController) {
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            controller.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        controller.didMove(toParent: self)
    }
    
    /// Note: The added view is centered, occupying full screen
    func showViewWithConstraints(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
    
    /// execute the publisher while showing an activity indicator
    func async<T, U: Error>(execute: () -> Future<T, U>) -> Publishers.FlatMap<Future<T, U>, Future<T, U>> {
        let ai = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        ai.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ai)
        ai.center = view.center
        ai.startAnimating()
        return execute()
            .flatMap { t in
                ai.stopAnimating()
                ai.removeFromSuperview()
                return Future<T, U> { $0(.success(t)) }
            }
    }
}
