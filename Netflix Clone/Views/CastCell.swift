//
//  CastCell.swift
//  Netflix Clone
//
//  Created by Hakan Baran on 2.03.2023.
//

import UIKit
import SDWebImage

class CastCell: UICollectionViewCell {
    
    static let identifier = "CastCell"
    
    public let castImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "duneWallpaper")
        return imageView
    }()
    
    public let castName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Hakan Baran"
        return label
        
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(castImage)
        self.contentView.addSubview(castName)
        
        castConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        castImage.frame = contentView.bounds
    }
    
    private func castConstraints() {
        
        let castImageConstraints = [
            castImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -10),
            castImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            castImage.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        let castNameConstraints = [
            castName.topAnchor.constraint(equalTo: castImage.bottomAnchor, constant: 7),
            castName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(castImageConstraints)
        NSLayoutConstraint.activate(castNameConstraints)
        
    }
    
    
    public func configure(with model : Cast) {
        
        guard let photo = model.profile_path else {return}
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(photo)") else {return}
        castImage.sd_setImage(with: url)
        
        castName.text = model.name
    }
}
