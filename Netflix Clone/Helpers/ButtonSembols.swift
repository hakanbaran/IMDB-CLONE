//
//  ButtonSembols.swift
//  Netflix Clone
//
//  Created by Hakan Baran on 2.03.2023.
//

import Foundation
import UIKit

class ButtonSembols: UIButton {
    
    init(symbol: String) {
        super.init(frame: .zero)
        configure(with: symbol)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with symbol: String) {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: symbol, withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        tintColor = .label
        configuration = config
    }
}
