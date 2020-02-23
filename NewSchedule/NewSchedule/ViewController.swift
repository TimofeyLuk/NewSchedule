//
//  ViewController.swift
//  NewSchedule
//
//  Created by IvanLyuhtikov on 2/23/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var arr = [["Ivan"],
                ["Ivan", "Andrey", "Bidlo", "Alex"],
                ["Ivan", "Tim", "Andrey", "Bidlo"],
                ["Ivan", "Tim", "Alex", "Jaja"],
                ["Ivan", "Tim", "Andrey", "Bidlo"],
                ["Bidlo", "Alex", "Jaja"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

