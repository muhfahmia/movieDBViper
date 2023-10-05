//
//  MovieDetailViewController.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 02/10/23.
//

import Foundation
import SkeletonView
import SDWebImage
import ToastViewSwift

protocol MovieDetailProtocol {
    var movieDetailPresenter: MovieDetailPresenterProtocol? { get set }
    func movieUpdateFavoriteSuccess()
    func movieUpdateFavoriteFailed()
    func movieUpdateSuccess(with movies: MovieModel?)
}

class MovieDetailViewController: UIViewController, MovieDetailProtocol {
    
    let scrollView = UIScrollView()
    let movieDetailView = UIView()
    let movieImage: UIImageView = {
        let mi = UIImageView()
        mi.image = nil
        mi.contentMode = .scaleToFill
        mi.translatesAutoresizingMaskIntoConstraints = false
        return mi
    }()
    
    let movieTitle: UILabel = {
        let md = UILabel()
        md.numberOfLines = 0
        md.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        md.skeletonTextNumberOfLines = 3
        md.skeletonTextLineHeight = .fixed(15)
        return md
    }()
    
    let movieDesc: UILabel = {
        let md = UILabel()
        md.numberOfLines = 0
        md.skeletonTextNumberOfLines = 5
        md.skeletonTextLineHeight = .fixed(15)
        return md
    }()
    
    let movieBtnFav: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add to Favorite", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.isUserInteractionEnabled = true
        btn.layer.cornerRadius = 18
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var movieDetailPresenter: MovieDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGrayCustom
        movieBtnFav.setWidth(view.frame.width-60)
        movieBtnFav.addTarget(self, action: #selector(addMovieFavorite), for: .touchUpInside)
        self.title = "Detail"
        setupScrollView()
        setupUI()
        setupSkeletonView()
        
        movieDetailPresenter?.getMovieDetail()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    @objc func addMovieFavorite() {
        movieDetailPresenter?.addMovieFavorite()
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        movieDetailView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(movieDetailView)
        scrollView.backgroundColor = .white
        scrollView.clipsToBounds = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            movieDetailView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            movieDetailView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            movieDetailView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            movieDetailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            movieDetailView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            // Add other constraints for your content's position and size within contentView
        ])
    }
    
    func setupUI() {
        movieDetailView.addSubview(movieImage)
        movieImage.anchor(top: movieDetailView.topAnchor, left: movieDetailView.leftAnchor, right: movieDetailView.rightAnchor, height: 170)
        movieDetailView.addSubview(movieTitle)
        movieTitle.anchor(top: movieImage.bottomAnchor, left: movieDetailView.leftAnchor, right: movieDetailView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10)
        movieDetailView.addSubview(movieDesc)
        movieDesc.anchor(top: movieTitle.bottomAnchor, left: movieDetailView.leftAnchor, right: movieDetailView.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingRight: 10)
        scrollView.addSubview(movieBtnFav)
        movieBtnFav.centerX(inView: scrollView)
        movieBtnFav.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func setupSkeletonView() {
        movieImage.isSkeletonable = true
        movieTitle.isSkeletonable = true
        movieDesc.isSkeletonable = true
        movieBtnFav.isSkeletonable = true
        DispatchQueue.main.async {
            self.movieImage.showAnimatedGradientSkeleton()
            self.movieTitle.showAnimatedGradientSkeleton()
            self.movieDesc.showAnimatedGradientSkeleton()
            self.movieBtnFav.showAnimatedSkeleton()
        }
    }
    
    func movieUpdateFavoriteSuccess() {
        let toast = Toast.default(
            image: UIImage(systemName: "heart.circle.fill")!,
            title: "Successfully",
            subtitle: "Movie add to Favorite list"
        )
        toast.show()
    }
    
    func movieUpdateFavoriteFailed() {
        let toast = Toast.default(
            image: UIImage(systemName: "heart")!,
            title: "Failed",
            subtitle: "Movie Favorite is already exist"
        )
        toast.show()
    }
    
    func movieUpdateSuccess(with movie: MovieModel?) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.movieBtnFav.isHidden = false
            self.movieTitle.hideSkeleton()
            self.movieDesc.hideSkeleton()
            self.movieBtnFav.hideSkeleton()
            self.movieImage.sd_setImage(with: URL(string: "\(Endpoints.movieDB.movieImage(size:"w400").url)\(movie!.posterImage)")) {
                (image, error, cacheType, imageUrl) in
                self.movieImage.hideSkeleton()
            }
            self.movieTitle.text = movie?.title
            self.movieDesc.text = movie?.description
        }
    }
    
}
