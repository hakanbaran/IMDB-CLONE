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
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel : UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hayri Pıtır"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        
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
        
        scrollView.frame = view.bounds
        
        
        let views = [titleLabel,dateLabel, overviewLabel, webView, moviePosterView, userScoreCirle]
        views.forEach { contentView.addSubview($0) }

        userScoreCirle.addSubview(userScoreLabel)
        
        configureConstraints()
        setupScrollView()

    }
    
    func setupScrollView(){
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            contentView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scrollView)
            scrollView.addSubview(contentView)
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
    

    func configureConstraints() {
        
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            webView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let moviePosterConstraints = [
            moviePosterView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 10),
            moviePosterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            moviePosterView.heightAnchor.constraint(equalToConstant: 140),
            moviePosterView.widthAnchor.constraint(equalToConstant: 98)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: moviePosterView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        
        let dateLabelConstraints = [
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: moviePosterView.trailingAnchor, constant: 10),
        ]
        
        let overViewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: moviePosterView.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10)
        ]
        
        
        userScoreLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(moviePosterConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(dateLabelConstraints)
        NSLayoutConstraint.activate(overViewLabelConstraints)
        
    }
    
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        let date = model.release_date
        let index = date.firstIndex(of: "-") ?? date.endIndex
        let year = date[..<index]
        
        dateLabel.text = "Release Date: \(year)"
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        webView.load(URLRequest(url: url))
        
        guard let posterURL = URL(string: "https://image.tmdb.org/t/p/w500/\(model.moviePoster)") else {return}
        moviePosterView.sd_setImage(with: posterURL)
        
        configureScoreLabel(with: model)
    }
    
    private func configureScoreLabel(with model: TitlePreviewViewModel) {
        
        let score = Int(model.vote_average * 10)
        let percentageScore = model.vote_average / 10
        userScoreLabel.text = "\(score)%"
        configureCircleStroke(with: percentageScore)
    }
    
    private func configureCircleStroke(with score: Double) {
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: userScoreCirle.frame.width / 2, y: userScoreCirle.frame.width / 2),
                                     radius: userScoreCirle.frame.width / 2,
                                     startAngle: CGFloat(-0.5 * Double.pi),
                                     endAngle: CGFloat(1.5 * Double.pi),
                                     clockwise: true)
        
        let circleShape         = CAShapeLayer()
        circleShape.path        = circlePath.cgPath
        circleShape.strokeColor = UIColor.yellow.cgColor
        circleShape.fillColor   = UIColor.white.withAlphaComponent(0.00001).cgColor
        circleShape.lineWidth   = 5
        circleShape.strokeStart = 0.0
        circleShape.strokeEnd   = score
        userScoreCirle.layer.addSublayer(circleShape)
    }
}
