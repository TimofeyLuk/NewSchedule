//
//  ViewController.swift
//  NewSchedule
//
//  Created by IvanLyuhtikov on 2/23/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import UIKit

// EXAMPLE HOW TO USE COLLEGE DATA

//RequestKBP.getData(stringURL: "https://kbp.by/rasp/timetable/view_beta_kbp/?cat=group&id=31")
//RequestKBP.dispGroup.wait()
//print(RequestKBP.PointsOfChanges ?? "ERROR")
//for pair in (RequestKBP.Curriculum!) {
//    print(pair?.pairName ?? "ERROR 2")

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

