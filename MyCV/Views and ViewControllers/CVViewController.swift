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
    private lazy var myCVViewModel = CVViewModel(api: BaseApi())
    private var cvBasicInfoView = BasicInfoView(frame: CGRect.zero)
    ///data source of `cvTable`
    private var cvData = [(String,[CVSectionProtocol])]()
    private let basicCVViewHeightFactor: CGFloat = 0.2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWaitingUI()
        
        NotificationCenter.default.addObserver(forName: .cvNotification,
                                               object: nil,
                                               queue: nil) {[weak self] (notification) in
                                                self?.handleNotification(notification: notification)
        }
        
        myCVViewModel.decodeCV()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

/// handle notification from `NotificationCenter`
extension CVViewController {
    
    private func handleNotification(notification: Notification) {
        if let cv = notification.userInfo?["cv"] as? MyCV {
            setupUI()
            cvBasicInfoView.cv = cv
            cvData = cv.sections
            cvTable?.reloadData()
        } else {
            let error = notification.userInfo?["cv"] as? Error
            setupErrorView(error: error)
        }
    }
}

///setup UI
extension CVViewController {
    
    private func setupUI() {
        
        for v in view.subviews {
            v.removeFromSuperview()
        }
        setupBasicInfoView()
        
        cvTable = UITableView(frame: CGRect.zero, style: .plain)
        cvTable?.delegate = self
        cvTable?.dataSource = self
        cvTable?.register(UITableViewCell.self, forCellReuseIdentifier: cvCellId)
        
        setupCVTable()
    }
    
    private func setupBasicInfoView() {
        
        view.addSubview(cvBasicInfoView)
        cvBasicInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cvBasicInfoView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            cvBasicInfoView.leftAnchor.constraint(equalTo: view.safeLeftAnchor),
            cvBasicInfoView.rightAnchor.constraint(equalTo: view.safeRightAnchor),
            cvBasicInfoView.heightAnchor.constraint(equalToConstant: view.bounds.height * basicCVViewHeightFactor)
        ])
        
    }
    
    private func setupCVTable() {
        
        if let table = cvTable {
            view.addSubview(table)
            table.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                table.topAnchor.constraint(equalTo: cvBasicInfoView.bottomAnchor),
                table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                table.bottomAnchor.constraint(equalTo: view.safeBottomAnchor),
            ])
        }
    }
    
    private func setupWaitingUI() {
        let label = UILabel()
        view.backgroundColor = .white
        label.text = "fetching CV..."
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupErrorView(error: Error?) {
        let unknownErrorMessage = "Unknown error"
        cvBasicInfoView.removeFromSuperview()
        cvTable?.removeFromSuperview()
        let errorLabel = UILabel()
        
        if let error = error {
            errorLabel.text = error.localizedDescription
        } else {
            errorLabel.text = unknownErrorMessage
        }
        
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

/// implement UITableView data source and delegate
extension CVViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //get the total section number from the tuples
        let (_, cvSections) = cvData[section]
        return cvSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //get section name from the tuples
        let (sectionName, _) = cvData[section]
        return sectionName
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return cvData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cvCellId, for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.text = cvData[indexPath.section].1[indexPath.row].toString()
        
        return cell
    }
}
