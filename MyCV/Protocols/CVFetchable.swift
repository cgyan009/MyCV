//
//  CVFetchable.swift
//  MyCV
//
//  Created by Chenguo Yan on 2019-12-24.
//  Copyright © 2019 Chenguo Yan. All rights reserved.
//

import Foundation

typealias dictionary = [String : Any]

protocol CVFetchable {
    func fetchCV(completion: @escaping (dictionary?, Error?) -> Void)
}
