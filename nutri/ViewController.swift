//
//  ViewController.swift
//  nutri
//
//  Created by Gla gla  on 20/05/22.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var btnComenzar: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnComenzar.clipsToBounds = true
        btnComenzar.layer.cornerRadius = 20
    }


}

