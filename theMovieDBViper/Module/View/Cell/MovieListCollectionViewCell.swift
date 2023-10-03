//
//  MovieListCollectionViewCell.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 27/09/23.
//

import UIKit
import SDWebImage

class MovieListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieListCell"
    
    let movieImage: UIImageView = {
        let mi = UIImageView()
        mi.image = UIImage(systemName: "photo")
        mi.contentMode = .scaleToFill
        return mi
    }()
    
    var moviesTitle: UILabel = {
        let ml = UILabel()
        ml.translatesAutoresizingMaskIntoConstraints = false
        ml.textColor = .black
        ml.font = UIFont(name: "Arial", size: 16)
        ml.numberOfLines = 2
        return ml
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 6
        
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieImage.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupUI() {
        self.addSubview(movieImage)
        self.addSubview(moviesTitle)
        movieImage.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingBottom: 5)
        moviesTitle.anchor(top: movieImage.bottomAnchor ,left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 5, paddingRight: 5)
    }
    
    func configure(with movie: MovieModel?) {
        self.moviesTitle.text = movie?.title ?? "Unknown Title"
        self.movieImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.movieImage.sd_setImage(with: URL(string: "\(Endpoints.movieDB.movieImage.url)\(movie!.posterImage)"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("Cell error")
    }
}
