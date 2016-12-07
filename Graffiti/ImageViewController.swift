//
//  ImageViewController.swift
//  Graffiti
//
//  Created by Timple Soft on 30/11/16.
//  Copyright © 2016 TimpleSoft. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    var selectedCallout : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedCallout = selectedCallout {
            img.image = selectedCallout
        }
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
