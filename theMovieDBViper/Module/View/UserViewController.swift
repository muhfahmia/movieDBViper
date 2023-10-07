//
//  UserViewController.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 07/10/23.
//

import Foundation
import UIKit
import SwiftUI

class UserViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    let scrollViewContent = UIView()
    
    let userViewSwiftUI = UserSwiftUI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "About"
        setupScrollView()
        
        let hostingUserSwift = UIHostingController(rootView: userViewSwiftUI)
        self.addChild(hostingUserSwift)
        scrollViewContent.addSubview(hostingUserSwift.view)
        hostingUserSwift.view.translatesAutoresizingMaskIntoConstraints = false
        
        hostingUserSwift.view.anchor(top: scrollViewContent.topAnchor, left: view.leftAnchor, bottom: scrollViewContent.bottomAnchor, right: view.rightAnchor)
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        self.view.addSubview(scrollView)
        self.scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        
        scrollView.addSubview(scrollViewContent)
        scrollViewContent.anchor(top: scrollViewContent.topAnchor, left: scrollViewContent.leftAnchor, bottom: scrollViewContent.bottomAnchor, right: scrollViewContent.rightAnchor)
        scrollViewContent.backgroundColor = .lightGrayCustom
    }
    
}
