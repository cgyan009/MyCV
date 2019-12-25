//
//  CVViewController.swift
//  MyCV
//
//  Created by Chenguo Yan on 2019-12-22.
//  Copyright © 2019 Chenguo Yan. All rights reserved.
//

import UIKit

private let cvCellId = "cvCell"

class CVViewController: UIViewController {
    
    private var cvTable: UITableView?
    private var cv: MyCV?
    private lazy var myCVViewModel = MyCVViewModel(api: BaseApi())
    private var cvBasicInfoView: BasicInfoView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self,selector: #selector(handleNotification(notification:)),
                                               name: NSNotification.Name(cvIsReadyNotification),
                                               object: nil)
        myCVViewModel.decodeCV()
    }
}

extension CVViewController {
    
    @objc func handleNotification(notification: Notification) {
        if let receivedCV = notification.userInfo?["cv"] as? MyCV {
            cv = receivedCV
            cvBasicInfoView?.cv = cv
            cvTable?.reloadData()
        } else {
            setupErrorView()
        }
    }
}

//setup UI
extension CVViewController {
    private func setupUI() {
        
        view.backgroundColor = UIColor.white
        
        setupBasicInfoView()
    }
    
    
    private func setupBasicInfoView() {
        
        cvBasicInfoView = BasicInfoView(frame: CGRect.zero)
        view.addSubview(cvBasicInfoView!)
        
        cvBasicInfoView?.translatesAutoresizingMaskIntoConstraints = false
        cvBasicInfoView?.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        cvBasicInfoView?.leftAnchor.constraint(equalTo: view.safeLeftAnchor).isActive = true
        cvBasicInfoView?.rightAnchor.constraint(equalTo: view.safeRightAnchor).isActive = true
        cvBasicInfoView?.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.2).isActive = true
    }
    
    private func setupErrorView() {
        cvBasicInfoView?.removeFromSuperview()
        cvTable?.removeFromSuperview()
        let errorLabel = UILabel()
        errorLabel.text = "Network error"
        
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}

