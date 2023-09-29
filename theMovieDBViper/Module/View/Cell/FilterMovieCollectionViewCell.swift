//
//  MovieListCollectionViewCell.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 27/09/23.
//

import UIKit
import SDWebImage

class FilterMovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "FilterMovieCell"
    
    let movieInput: UITextField = {
        let mi = UITextField()
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, mi.frame.height))
        mi.placeholder = "Search movie"
        mi.backgroundColor = .white
        mi.layer.cornerRadius = 25
        mi.leftView = paddingView
        mi.leftViewMode = .always
        return mi
    }()
    
    let movieImageFilter: UIImageView = {
       let mif = UIImageView()
        mif.image = UIImage(systemName: "line.3.horizontal.decrease.circle.fill")
        mif.tintColor = .systemTeal
        mif.setDimensions(height: 50, width: 50)
        mif.isUserInteractionEnabled = true
        return mif
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupUI() {
        self.addSubview(movieInput)
        self.addSubview(movieImageFilter)
        movieInput.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        movieImageFilter.anchor(top: self.topAnchor, left: movieInput.rightAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        movieImageFilter.addGestureRecognizer(tap)
    }
    required init?(coder: NSCoder) {
        fatalError("Cell error")
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            // Handle the tap event here
            print("Filter tapped!")
        }
    }
    
}
