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
    ///data source of `cvTable`
    private var cvData = [(String,[CVSectionProtocol])]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self,selector: #selector(handleNotification(notification:)),
                                               name: NSNotification.Name(cvIsReadyNotification),
                                               object: nil)
        myCVViewModel.decodeCV()
    }
}

/// handle notification from `NotificationCenter`
extension CVViewController {
    
    @objc func handleNotification(notification: Notification) {
        if let receivedCV = notification.userInfo?["cv"] as? MyCV {
            cv = receivedCV
            cvBasicInfoView?.cv = cv
            cvData = receivedCV.cvSections
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
        
        view.backgroundColor = UIColor.white
        
        setupBasicInfoView()
        
        cvTable = UITableView(frame: CGRect.zero, style: .plain)
        cvTable?.delegate = self
        cvTable?.dataSource = self
        cvTable?.register(UITableViewCell.self, forCellReuseIdentifier: cvCellId)
        
        setupCVTable()
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
    
    private func setupCVTable() {
        
        if let table = cvTable,
            let basicInfoView = cvBasicInfoView {
            view.addSubview(table)
            table.translatesAutoresizingMaskIntoConstraints = false
            table.topAnchor.constraint(equalTo: basicInfoView.bottomAnchor).isActive = true
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            table.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        }
    }
    
    private func setupErrorView(error: Error?) {
        let unknownErrorMessage = "Unknown error"
        cvBasicInfoView?.removeFromSuperview()
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
