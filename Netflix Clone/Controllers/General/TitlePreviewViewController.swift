//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Hakan Baran on 28.12.2022.
//

import UIKit
import WebKit
import SnapKit
import SDWebImage

class TitlePreviewViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    
    private let titleLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Harry potter"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let moviePosterView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.image = UIImage(named: "duneWallpaper")
        return imageView
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This is the best movie ever to watch as a kid"
        return label
    }()
    
    
    
    private let webView: WKWebView = {
       let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
        
    }()
    
    private let userScoreLabel : UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let userScoreCirle  = {
        
        let roundView = UIView(frame: CGRectMake(310, 380, 60, 60))
        roundView.backgroundColor    = UIColor.systemBackground
        roundView.layer.cornerRadius = roundView.frame.width / 2
        return roundView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        
        
        
        
        let views = [titleLabel, overviewLabel, webView, moviePosterView, userScoreCirle]
        views.forEach { view.addSubview($0) }

        userScoreCirle.addSubview(userScoreLabel)
        
        configureConstraints()

        
        
    }
    
//    func setupScrollView() {
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//    }
    
    
    
    
    
    func configureConstraints() {
        
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        

        
        let moviePosterConstraints = [
            moviePosterView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 10),
            moviePosterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            moviePosterView.heightAnchor.constraint(equalToConstant: 140),
            moviePosterView.widthAnchor.constraint(equalToConstant: 98)
        ]
        
        let titleLabelConstraints = [
        
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: moviePosterView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
            
        ]
        
        let overViewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: moviePosterView.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        
        userScoreLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(moviePosterConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overViewLabelConstraints)
        
        
        
    }
    
    
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        webView.load(URLRequest(url: url))
        
        
        guard let posterURL = URL(string: "https://image.tmdb.org/t/p/w500/\(model.moviePoster)") else {return}
        
        moviePosterView.sd_setImage(with: posterURL)
        
    }
    
    
}
