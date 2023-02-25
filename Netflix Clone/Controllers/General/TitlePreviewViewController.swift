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
    
    var viewModel : TitlePreviewViewModel?
    
    private lazy var favoriteButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.tintColor = .lightGray
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(addFavoriteClicked), for: .touchUpInside)
        
//        button.target(forAction: #selector(addFavoriteClicked), withSender: nil)
        return button
        
    }()
    
    private let titleMediaType: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .lightGray
        
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 0.5
        
        return label
    }()
    
    
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
        label.font = .systemFont(ofSize: 16, weight: .regular)
        
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .lightGray
        
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 0.5
        
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
    
    private let overviewTitleLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Overview"
        return label
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
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let userScoreCirle  = {
        
        let roundView = UIView(frame: CGRectMake(320, 12, 50, 50))
        roundView.backgroundColor    = UIColor.systemBackground
        roundView.layer.cornerRadius = roundView.frame.width / 2
        return roundView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .lightGray
        view.backgroundColor = .systemBackground
        
        scrollView.frame = view.bounds
        
        
        let views = [titleLabel,dateLabel, overviewLabel, overviewTitleLabel, webView, moviePosterView, titleMediaType, userScoreCirle]
        views.forEach { contentView.addSubview($0) }

        userScoreCirle.addSubview(userScoreLabel)
        
        configureConstraints()
        setupScrollView()
    }
    
    @objc func addFavoriteClicked() {
        
        guard let viewModel = viewModel else {return}
        
        DataPersistenceManager.shared.downloadTitleWith(model: viewModel) { result in
            switch result {
            case .success():
                print("Download to Database")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
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
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        
        let movieMediaTypeConstraints = [
            titleMediaType.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
            titleMediaType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleMediaType.widthAnchor.constraint(equalToConstant: 80),
            titleMediaType.heightAnchor.constraint(equalToConstant: 25)
        ]
        
        let dateLabelConstraints = [
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: titleMediaType.trailingAnchor, constant: 10),
            dateLabel.widthAnchor.constraint(equalToConstant: 80),
            dateLabel.heightAnchor.constraint(equalToConstant: 25)
        ]
        
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: titleMediaType.bottomAnchor, constant: 10),
            webView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        let moviePosterConstraints = [
            moviePosterView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 10),
            moviePosterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            moviePosterView.heightAnchor.constraint(equalToConstant: 140),
            moviePosterView.widthAnchor.constraint(equalToConstant: 98)
        ]
        
        
        
        let overViewTitleLabelConstraints = [
            overviewTitleLabel.topAnchor.constraint(equalTo: moviePosterView.bottomAnchor,constant: 20),
            overviewTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20)
        
        
        ]
        
        let overViewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10)
        ]
        
        
        userScoreLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        
        let favoriteButtonConstraints = [
            favoriteButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            favoriteButton.leadingAnchor.constraint(equalTo: moviePosterView.trailingAnchor, constant: 10)
        
        ]
        
        
        
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(moviePosterConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(dateLabelConstraints)
        NSLayoutConstraint.activate(overViewTitleLabelConstraints)
        NSLayoutConstraint.activate(overViewLabelConstraints)
        
//        NSLayoutConstraint.activate(favoriteButtonConstraints)
        NSLayoutConstraint.activate(movieMediaTypeConstraints)
        
    }
    
    func configure(with model: TitlePreviewViewModel) {
        
        self.viewModel = model
        
        title = model.title
        
        
        
        let upperMediaType = model.media_type.uppercased()
        
        if upperMediaType == "TV" {
            titleMediaType.text = upperMediaType + " Series"
        } else {
            titleMediaType.text = upperMediaType
            
        }
        
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        
        
        let date = model.release_date
        let index = date.firstIndex(of: "-") ?? date.endIndex
        let year = date[..<index]
        
        dateLabel.text = String(year)
        
        
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
//        userScoreLabel.text = "\(score)%"
        
        let scoreResult = Double(score / 10)
        
        userScoreLabel.text = "\(scoreResult)/10"
        
        print(userScoreLabel.text)
        
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
