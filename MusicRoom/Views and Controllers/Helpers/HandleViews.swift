//
//  HandleViews.swift
//  MusicRoom
//
//  Created by Nguyen Tam Anh Bui on 7/30/18.
//  Copyright © 2018 Nguyen Tam Anh Bui. All rights reserved.
//

import Foundation
import UIKit

class HandleViews: UIViewController {
    func switchScreen(_ identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier) as UIViewController
        return controller
    }

}

