//
//  ImageViewController.swift
//  Cassini
//
//  Created by Julea Parkhomava on 2/27/21.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    var imageURL: URL?{
        didSet{
            image = nil
            if view.window != nil{
                fetchImage()
            }
        }
    }
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var image: UIImage?{
        get{
            imageView.image
        }
        set{
            imageView.image = newValue
            spinner?.stopAnimating()
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if image == nil{
            fetchImage()
        }
    }
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        imageURL = DemoURLs.stanford
    }
    
    @IBOutlet weak var imageView: UIImageView!*/
    
    var imageView = UIImageView()
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
    
    private func fetchImage(){
        if let url = imageURL{
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                if let urlContent = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        if let imageData = UIImage(data: urlContent), url == self?.imageURL{
                            self?.image = imageData
                        }
                    }
                }
            }
        }
    }
    
}
