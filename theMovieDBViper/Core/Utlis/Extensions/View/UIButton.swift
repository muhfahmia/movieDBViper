//
//  UIButton.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 30/09/23.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    enum enumBtnType {
        case primary
        case danger
    }
    
    var btnTitle: String
    var btnType: enumBtnType
    
    init(btnTitle titel: String, btnType tipe: enumBtnType) {
        self.btnTitle = titel
        self.btnType = tipe
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
   
        self.setTitle(self.btnTitle, for: .normal)
        self.btnConfigureStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func btnConfigureStyle() {
        switch self.btnType {
        case .primary:
            self.backgroundColor = .systemTeal
        case .danger:
            self.backgroundColor = .red
        }
    }
    
}


extension UIButton {
    func attributedTitle(firstPart: String, secondPart: String) {
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart) ", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.boldSystemFont(ofSize: 16)]
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: boldAtts))
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
