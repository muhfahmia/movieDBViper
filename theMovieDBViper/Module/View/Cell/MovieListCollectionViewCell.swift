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
    
    var movieFavoPresenter: MovieFavoritePresenterProtocol?
    
    let movieBtnTooltip: UIButton = {
        let mv = UIButton()
        mv.backgroundColor = .clear
        mv.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        mv.tintColor = .blue
        return mv
    }()
    
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
    
    var movie: MovieModel?
    var indexPath: IndexPath?
    
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
        movieImage.setHeight(160)
       
    }
    
    func configure(with movie: MovieModel?, tooltip ti: String, indexPath: IndexPath) {
        self.movie = movie
        self.indexPath = indexPath
        self.movieImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.movieImage.sd_setImage(with: URL(string: "\(Endpoints.movieDB.movieImage(size: "w200").url)\(movie!.posterImage)"))
        self.moviesTitle.text = movie?.title ?? "Unknown Title"
        if ti == "yes" {
            setupTooltip()
        }
    }
    
    func setupTooltip() {
        self.addSubview(movieBtnTooltip)
        movieBtnTooltip.anchor(top: self.topAnchor, right: self.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 25, height: 25)
        movieBtnTooltip.layer.cornerRadius = 12.5
        movieBtnTooltip.addTarget(self, action: #selector(self.ObjbtnTooltip), for: .touchUpInside)
    }
    
    @objc func ObjbtnTooltip() {
        btnTooltip()
    }
    
    func btnTooltip() {
        movieFavoPresenter?.deleteMovieAction(with: self.movie!, indexPath: self.indexPath!)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Cell error")
    }
}
