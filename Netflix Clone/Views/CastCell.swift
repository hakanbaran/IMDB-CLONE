//
//  CastCell.swift
//  Netflix Clone
//
//  Created by Hakan Baran on 2.03.2023.
//

import UIKit

class CastCell: UICollectionViewCell {
    
    static let identifier = "CastCell"
    
    var castImage : UIImageView = {
        
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(castImage)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        castImage.frame = contentView.bounds
    }
    
    
    
    
    
}
