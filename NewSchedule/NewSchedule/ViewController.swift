//
//  ViewController.swift
//  NewSchedule
//
//  Created by IvanLyuhtikov on 2/23/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import UIKit


// EXAMPLE HOW TO USE COLLEGE DATA
//RequestKBP.getData(stringURL: links[links.keys[links.keys.startIndex]] ?? "")
//
// >>>>>>> ther can be same interface drowing or ather function without college data
//
//       RequestKBP.dispGroup.wait()
//
// >>>>>> NEXT is optional example of printint data. u can use the saim for validation
//
//       print(RequestKBP.PointsOfChanges ?? "Change of pair ERROR")   // curriculum changes for all days 
//       for pair in (RequestKBP.Curriculum!) {
//           print((pair?.pairName ?? "Pair ERROR") + " " + (pair?.group ?? "Group ERROR"))
//       }


class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var arr = [[("1", "МатМод", "Белугина", "8:30-10:00", "415"), ("2", "ТРПО", "Шукалович", "10:10-11:40", "403")],
                [("1", "Химия", "Блогер", "8:30-10:00", "415"), ("2", "МатМод", "Белугина", "10:10-11:40", "403"), ("3", "Экономика", "Григораш", "14:10-15:40", "509")],
                [("1", "МатМод", "Белугина", "8:30-10:00", "415"), ("2", "МатМод", "Белугина", "8:30-10:00", "415"), ("3", "МатМод", "Белугина", "8:30-10:00", "415"), ("4", "МатМод", "Белугина", "8:30-10:00", "415")],
                [("1", "МатМод", "Белугина", "8:30-10:00", "415"), ("2", "МатМод", "Белугина", "8:30-10:00", "415"), ("3", "МатМод", "Белугина", "8:30-10:00", "415")],
                [("1", "КонсПрогрИЯзПр", "Михалевич В", "8:30-10:00", "415"), ("2", "Биология", "Белугина", "8:30-10:00", "415"), ("3", "БухУчет", "Старая Хуйня", "8:30-10:00", "415"), ("4", "МатМод", "Белугина", "8:30-10:00", "415")],
                [("1", "ТестОтладкаПО", "Белугина", "8:30-10:00", "415"), ("2", "МатМод", "Белугина", "8:30-10:00", "415"), ("3", "МатМод", "Белугина", "8:30-10:00", "415")]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
