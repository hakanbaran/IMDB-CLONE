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
    
    let castView = UIView()
    
    var viewModel : TitlePreviewViewModel?
    
    private var casts : [Cast] = [Cast]()
    
    private lazy var favoriteButton : UIButton = {
        let button = ButtonSembols(symbol: "heart")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        button.isUserInteractionEnabled = true
        return button
    }()
    private lazy var downloadButton : UIButton = {
        let button = ButtonSembols(symbol: "bookmark")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        button.isUserInteractionEnabled = true
//        button.addTarget(self, action: #selector(addDownloadClicked), for: .touchUpInside)
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
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Overview"
        return label
    }()
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 9
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
    
    
    
    private let castTitleLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = .secondarySystemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "   Top Casts"
//        label.textAlignment = .center
//        label.clipsToBounds = true
//        label.layer.cornerRadius = 5
        return label
    }()
    
    
    private let collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .secondarySystemBackground
        return collectionView
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .lightGray
        view.backgroundColor = .systemBackground
        
        scrollView.frame = view.bounds
        
        let views = [titleLabel, dateLabel, overviewLabel, overviewTitleLabel, webView, favoriteButton, downloadButton , moviePosterView,castTitleLabel, collectionView , titleMediaType, userScoreCirle]
        views.forEach { contentView.addSubview($0) }
        userScoreCirle.addSubview(userScoreLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        configureConstraints()
        setupScrollView()
        
        contentView.addSubview(collectionView)
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: CastCell.identifier)
    }
    
    @objc func addFavoriteClicked() {
    }
    
    @objc func addDownloadClicked() {
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
    
    func setupCastView() {
            
        castView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(castView)
        
        castView.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 20).isActive = true
        castView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        castView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        castView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        castView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        castView.heightAnchor.constraint(equalToConstant: 210).isActive = true
        
        castView.backgroundColor = .cyan
        
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
            moviePosterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviePosterView.heightAnchor.constraint(equalToConstant: 160),
            moviePosterView.widthAnchor.constraint(equalToConstant: 112)
        ]
        
        
        
        let overViewTitleLabelConstraints = [
            overviewTitleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor,constant: 10),
            overviewTitleLabel.leadingAnchor.constraint(equalTo: moviePosterView.trailingAnchor, constant: 10)
        
        
        ]
        
        let overViewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 5),
            overviewLabel.leadingAnchor.constraint(equalTo: moviePosterView.trailingAnchor, constant: 10),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        
        userScoreLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        
        let favoriteButtonConstraints = [
            favoriteButton.topAnchor.constraint(equalTo: moviePosterView.bottomAnchor, constant: 15),
            favoriteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            favoriteButton.widthAnchor.constraint(equalToConstant: 25),
            favoriteButton.heightAnchor.constraint(equalToConstant: 25)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.topAnchor.constraint(equalTo: moviePosterView.bottomAnchor, constant: 15),
            downloadButton.leadingAnchor.constraint(equalTo: favoriteButton.trailingAnchor, constant: 20),
            downloadButton.widthAnchor.constraint(equalToConstant: 25),
            downloadButton.heightAnchor.constraint(equalToConstant: 25)
        
        ]
        
        let castTitleConstraints = [
            castTitleLabel.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 10),
            castTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            castTitleLabel.heightAnchor.constraint(equalToConstant: 28)
        
        
        ]
        
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: castTitleLabel.bottomAnchor, constant: -5),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 240)
        ]
        
        
        
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(moviePosterConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(dateLabelConstraints)
        NSLayoutConstraint.activate(overViewTitleLabelConstraints)
        NSLayoutConstraint.activate(overViewLabelConstraints)
        
        NSLayoutConstraint.activate(favoriteButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
        NSLayoutConstraint.activate(movieMediaTypeConstraints)
        
        NSLayoutConstraint.activate(castTitleConstraints)
        NSLayoutConstraint.activate(collectionViewConstraints)
        
        
        
//        NSLayoutConstraint.activate(castViewConstraints)
        
        
        
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
        
        APICaller.shared.getMovieCasts(with: model.id, with: model.media_type) { results in
            switch results {
            case .success(let cast):
                self.casts = cast
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        configureScoreLabel(with: model)
    }
    
    private func configureScoreLabel(with model: TitlePreviewViewModel) {
        
        let score = model.vote_average * 10
        let percentageScore = model.vote_average / 10
//        userScoreLabel.text = "\(score)%"
        
        let scoreResult = Double(score / 10)
        
        
        let roundScore = Double(round(10 * scoreResult) / 10)
        
       
        
        
        userScoreLabel.text = "\(roundScore)/10"
        
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

extension TitlePreviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.identifier, for: indexPath) as! CastCell
        
        let cast = casts[indexPath.item]
        cell.castName.text = cast.name
        let posterURL = URL(string: "https://image.tmdb.org/t/p/w500/\(cast.profile_path ?? "")")

        cell.castImage.sd_setImage(with: posterURL)
        
        
        return cell
    }
}
