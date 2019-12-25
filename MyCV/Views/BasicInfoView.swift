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

extension BasicInfoView {
    
    private func setupUI() {
        guard let cv = cv else {
            return
        }
        nameLabel.text = cv.basics.name
        emailLabel.text = cv.basics.email
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
        
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
        
        nameLabel.text = cv.basics.name
        nameLabel.font = .systemFont(ofSize: 24)
        nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 6).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
        
        emailLabel.text = "email: \(cv.basics.email)"
        emailLabel.font = .systemFont(ofSize: 18)
        emailLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12).isActive = true
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6).isActive = true
        
        websiteLabel.text = "website: \(cv.basics.website)"
        websiteLabel.font = .systemFont(ofSize: 18)
        websiteLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor).isActive = true
        websiteLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 6).isActive = true
        
        locationLabel.text = cv.basics.location.toString()
        locationLabel.sizeToFit()
        locationLabel.lineBreakMode = .byWordWrapping
        locationLabel.numberOfLines = 0
        locationLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor).isActive = true
        locationLabel.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 6).isActive = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
}
