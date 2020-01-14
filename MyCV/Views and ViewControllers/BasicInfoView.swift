//
//  BasicInfoView.swift
//  MyCV
//
//  Created by Chenguo Yan on 2019-12-25.
//  Copyright © 2019 Chenguo Yan. All rights reserved.
//

import UIKit

class BasicInfoView: UIView {
    
    private lazy var nameLabel = UILabel()
    private lazy var emailLabel = UILabel()
    private lazy var websiteLabel = UILabel()
    private lazy var locationLabel = UILabel()
    private lazy var imageView = UIImageView()
    
    private let insetConstant: CGFloat = 6.0
    private let distanceToImageView: CGFloat = 12.0
    private let nameFontSize: CGFloat = 24.0
    private let contentFontSize: CGFloat = 18.0
    
    var cv: MyCV? {
        didSet {
            setNeedsLayout()
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

///setup UI
extension BasicInfoView {
    
    private func setupUI() {
        guard let cv = cv else {
            return
        }
        nameLabel.text = cv.basics.name
        websiteLabel.text = cv.basics.website
        
        if let url = URL(string: cv.basics.picture),
            let data = try? Data(contentsOf: url) {
            imageView.image = UIImage(data: data)
            
        } else {
            imageView.image = UIImage(named: "default_img")
            
        }
        self.addSubview(nameLabel)
        self.addSubview(emailLabel)
        self.addSubview(websiteLabel)
        self.addSubview(imageView)
        self.addSubview(locationLabel)
        
        for view in subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: insetConstant),
            imageView.widthAnchor.constraint(equalToConstant: self.bounds.height),
            imageView.heightAnchor.constraint(equalToConstant: self.bounds.height)
        ])
        
        nameLabel.font = .systemFont(ofSize: nameFontSize)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: distanceToImageView),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: insetConstant)
        ])
        
        emailLabel.text = "email: \(cv.basics.email)"
        emailLabel.font = .systemFont(ofSize: contentFontSize)
        NSLayoutConstraint.activate([
            emailLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: distanceToImageView),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: insetConstant)
        ])
        
        websiteLabel.text = "website: \(cv.basics.website)"
        websiteLabel.font = .systemFont(ofSize: contentFontSize)
        NSLayoutConstraint.activate([
            websiteLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            websiteLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: insetConstant)
        ])
    
        locationLabel.text = cv.basics.location.toString()
        locationLabel.sizeToFit()
        locationLabel.lineBreakMode = .byWordWrapping
        locationLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            locationLabel.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: insetConstant)
        ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
}
