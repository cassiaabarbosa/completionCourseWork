//
//  UIViewController + UIViewControllerRepresentable.swift
//  tcc
//
//  Created by Cassia Barbosa on 06/06/21.
//
#if DEBUG
import Foundation
import UIKit
import SwiftUI

extension UIViewController {
    
    struct Representable: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }
        
        
        var viewController: UIViewController
        typealias UIViewControllerType = UIViewController
        
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
    
    var representable: Representable {
        Representable(viewController: self)
    }
}
#endif
