//
//  ViewController.swift
//  SignatureDraw
//
//  Created by Fardan Akhter on 7/15/20.
//  Copyright © 2020 Fardan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signatureImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        signatureImageView.contentMode = .scaleAspectFit
        
        if let data = UserDefaults.standard.value(forKey: "signature"){
            signatureImageView.image = UIImage(data: data as! Data)
        }
        
    }

}

