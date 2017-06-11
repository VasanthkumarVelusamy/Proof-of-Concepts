//
//  ViewController.swift
//  GCDExample
//
//  Created by Vasanthkumar V on 01/06/17.
//  Copyright © 2017 Vasanthkumar V. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var image: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }

    @IBAction func ShowNextImage(_ sender: UIButton) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let randomNumber = Int(arc4random_uniform(9))
        chooseURL(for: randomNumber)
        
    }
    
    func chooseURL(for number: Int) {
        var URLString = ""
        switch number {
        case 0:
            URLString = "https://www.tesla.com/tesla_theme/assets/img/modelx/section-cargo.jpg?20170420"
        case 1:
            URLString = "https://www.tesla.com/tesla_theme/assets/img/models/section-hero-background.jpg?20170420"
        case 2:
            URLString = "https://www.tesla.com/tesla_theme/assets/img/modelx/section-exterior-profile.jpg?20170420"
        case 3:
            URLString = "https://www.tesla.com/tesla_theme/assets/img/modelx/section-exterior-primary.jpg?20170420"
        case 4:
            URLString = "https://www.tesla.com/tesla_theme/assets/img/modelx/section-checkboard-aero.jpg?20170420"
        case 5:
            URLString = "https://www.tesla.com/tesla_theme/assets/img/modelx/section-cargo.jpg?20170420"
        case 6:
            URLString = "https://www.tesla.com/sites/default/files/images/charging/section-wall_connector-alt.jpg?20170511"
        case 7:
            URLString = "https://www.tesla.com/tesla_theme/assets/img/charging/section-supercharger-alt.jpg?20170511"
        case 8:
            URLString = "https://www.tesla.com/tesla_theme/assets/img/charging/section-destination_charging-alt.jpg?20170511"
        case 9:
            URLString = "https://www.tesla.com/sites/default/files/images/supercharger/supercharger-hero@2x.jpg"
        default:
            break
        }
        let imageURL = URL(string: URLString)
        if let validURL = imageURL {
            fetchNextImage(with: validURL)
        }
    }
    
    
    
    func fetchNextImage(with url: URL) {
        
        DispatchQueue.global(qos: DispatchQoS.userInitiated.qosClass).async {
            let fetch = NSData(contentsOf: url as URL)
            if let imageData = fetch {
                self.image = UIImage(data: imageData as Data)!
            }
            DispatchQueue.main.async {
                if self.image != nil {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.imageView.image = self.image
                }
            }
        }
    }
    
    

}

