//
//  MyCVViewModel.swift
//  MyCV
//
//  Created by Chenguo Yan on 2019-12-25.
//  Copyright © 2019 Chenguo Yan. All rights reserved.
//

import Foundation

import Foundation

///this is also used in `CVViewController`
let cvIsReadyNotification = "cv is ready"

class MyCVViewModel {
    
    let api: CVFetchable
    
    init(api: CVFetchable) {
        self.api = api
    }
    
    func decodeCV() {
        api.fetchCV {[weak self] (json, error) in
            if let error = error {
                self?.handleError(error: error)
                return
            } else if let json = json {
                do {
                    let data = try JSONSerialization.data(withJSONObject: json, options: [])
                    let cv = try JSONDecoder().decode(MyCV.self, from: data)
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name(cvIsReadyNotification),
                                                        object: nil,
                                                        userInfo: ["CV": cv])
                    }
                    
                } catch {
                    self?.handleError(error: error)
                }
            }
        }
    }
    private func handleError(error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Notification.Name(cvIsReadyNotification),
                                            object: nil,
                                            userInfo: ["CV": error])
        }
    }
}
