//
//  CityTableViewCell.swift
//  Meteo
//
//  Created by Leo Marcotte on 24/10/2017.
//  Copyright © 2017 Leo Marcotte. All rights reserved.
//

import UIKit
import Material

class CityTableViewCell: TableViewCell {

    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        prepareTitleLabel()
        prepareDescriptionLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func prepareTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = RobotoFont.bold(with: 18)
        titleLabel.tintColor = .black
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -4).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16).isActive = true
    }
    
    fileprivate func prepareDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.font = RobotoFont.regular(with: 14)
        descriptionLabel.tintColor = .black
        addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 4).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16).isActive = true
    }
    
    
    
}
