//
//  CossiniViewController.swift
//  Cassini
//
//  Created by Julea Parkhomava on 2/27/21.
//

import UIKit

class CossiniViewController: UIViewController {
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            if let url = DemoURLs.NASA[identifier]{
                if let imageVC = segue.destination.content as? ImageViewController{
                    imageVC.imageURL = url
                    imageVC.title = (sender as? UIButton)?.currentTitle ?? "\(url)"
                }
            }
        }
    }

}

extension UIViewController{
    var content: UIViewController{
        if let navcon = self as? UINavigationController{
            return navcon.visibleViewController ?? self
        }
        return self
    }
}
