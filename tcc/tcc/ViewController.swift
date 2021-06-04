//
//  ViewController.swift
//  tcc
//
//  Created by Cassia Barbosa on 03/06/21.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @TemplateView var scanButton: ScanButton
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return  .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tccBlack
        setupNavigationControllerAttributes()
        buildViewHierarchy()
        applyConstraints()
        setupScanButton()
    }

    private func setupNavigationControllerAttributes() {
        navigationController?.navigationBar.barTintColor = .tccBlack
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func buildViewHierarchy() {
        view.addSubview(scanButton)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            scanButton.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: self.view.safeAreaLayoutGuide.layoutFrame.height * 0.1),
            scanButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            scanButton.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.7),
            scanButton.heightAnchor.constraint(equalToConstant: self.view.frame.width * 0.7)
        ])
    }
    
    private func setupScanButton() {
        scanButton.clipsToBounds = true
        scanButton.layer.cornerRadius = (self.view.frame.width * 0.7) / 2
    }
    
}

