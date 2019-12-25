//
//  UIView+SafeAnchor.swift
//  MyCV
//
//  Created by Chenguo Yan on 2019-12-25.
//  Copyright © 2019 Chenguo Yan. All rights reserved.
//

import UIKit
///for iOS version lower than 11.0, there is not `safeAreaLayoutGuide`, just return the `Anchor`
extension UIView {

  var safeTopAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.topAnchor
    }
    return self.topAnchor
  }

  var safeLeftAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return self.safeAreaLayoutGuide.leftAnchor
    }
    return self.leftAnchor
  }

  var safeRightAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return self.safeAreaLayoutGuide.rightAnchor
    }
    return self.rightAnchor
  }

  var safeBottomAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.bottomAnchor
    }
    return self.bottomAnchor
  }
}
