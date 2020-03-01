//
//  RequestKBP.swift
//  NewSchedule
//
//  Created by Тимофей Лукашевич on 2/23/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import UIKit

typealias CurriculumDay = (pairName: String, teacher: String, room: String, group: String, numberPare: String)?


class RequestKBP {
    
    static let dispGroup = DispatchGroup()
    static var Curriculum :[CurriculumDay] = []
    static var PointsOfChanges: [String] = []
    
    
    class func getData(stringURL: String) {
 
        dispGroup.enter()
        guard let url = URL(string: stringURL) else { return }
        
        _ = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            let htmlContext = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            RequestKBP.PointsOfChanges = getChangeOfPairSwitcher(html: htmlContext)
            let weeksData = searchByRegularExpresion(regularEx: #"<table.+>(\s*|.)+(<\/table>)"#, str: htmlContext ?? "")
            var pairsData: [String] = []
            
            for el in weeksData {
                pairsData += searchByRegularExpresion(regularEx: #"<td>(\s*|.)*<\/td>"#, str: el)
            }
            pairsData = pairsData.map({ str in str
                .replacingOccurrences(of: #"<td>\s*<!.+>\s*(<div\s*class=\"pair\s*lw_\d\">\s*)?(<div\s*class=\".+-column\">)?"#, with:"" , options : .regularExpression)
                .replacingOccurrences(of: #"\s*((<\/tr>)|(<\/td>))"#, with:"" , options : .regularExpression)
                .replacingOccurrences(of: #"</tbody></table>"#, with:"" , options : .regularExpression)
                .replacingOccurrences(of: #"(<div\s*class=\")|(\">)|(<\/div>)"#, with:"" , options : .regularExpression)
                .replacingOccurrences(of: #"<a\s*href=\"\?\s*cat=.*;id=\d{0,2}"#, with:"" , options : .regularExpression)
                .replacingOccurrences(of: #"(<!.+>)|(pair\s*(r|l)w_\d(\s*week\s*week\d)?\s*)"#, with:"" , options : .regularExpression)
                .replacingOccurrences(of: #"(<\/a>)|((right|left)-column)|(<\/span>)"#, with:"" , options : .regularExpression)
                .replacingOccurrences(of: #"group<span\s*class=\"group-"#, with:"" , options : .regularExpression)
                .replacingOccurrences(of: #"(\t+)|(extra)"#, with:"" , options : .regularExpression)
                .replacingOccurrences(of: #"removed\s*(.+\s+){3,10}added"#, with:"" , options : .regularExpression)
                
            })

            var tempCurriculum: [CurriculumDay] = []
            
            for index in 0..<pairsData.count
            {
                let subject = searchByRegularExpresion(regularEx: #"(subject\w+\d*\(?\w*)|(empty-pair)"#, str: pairsData[index]).map({str in str
                    .replacingOccurrences(of: #"subject"#, with:"" , options : .regularExpression)}).getTotalResult()
               
                if subject == "empty-pair"{
                    tempCurriculum.append(("пары нет", "👨🏼‍💻", "🤷‍♂️", "🥳", ""))
                }
                else{
                    let room = searchByRegularExpresion(regularEx: #"place\s*.{1,4}"#, str: pairsData[index]).map({str in str
                                       .replacingOccurrences(of: #"place"#, with:"" , options : .regularExpression)}).getTotalResult()
                    
                    let teacher = searchByRegularExpresion(regularEx: #"teacher\w+(\s{0,2}\w\.?){0,2}"#, str: pairsData[index]).map({str in str
                    .replacingOccurrences(of: #"teacher"#, with:"" , options : .regularExpression)}).getTotalResult()
                    
                    let group = searchByRegularExpresion(regularEx: #"span\w-\d{3}"#, str: pairsData[index]).map({str in str
                    .replacingOccurrences(of: #"span"#, with:"" , options : .regularExpression)}).getTotalResult()
                    
                    tempCurriculum.append((subject, teacher, room, group, ""))
                }
            }
            
            for day in 0...5
            {
                for pair in 0...6
                {
                    var pairInfo = tempCurriculum[(pair * 6) + day]
                    pairInfo?.numberPare = "\(pair+1)"
                    Curriculum.append(pairInfo)
                }
            }
            for day in 0...5
            {
                for pair in 0...6
                {
                    var pairInfo = tempCurriculum[42 + day + (pair*6)]
                    pairInfo?.numberPare = "\(pair+1)"
                    Curriculum.append(pairInfo)
                }
            }
            

            dispGroup.leave()
            
        }.resume()
    }
       
    private class func getChangeOfPairSwitcher (html: String? ) -> [String] {
        
        var result = [String]()
        let htmlContext = html?.replacingOccurrences(of: #"\s+"#, with: " ", options: .regularExpression)
        var htmlDataOfChanges = searchByRegularExpresion(regularEx: #"<tr class=\"zamena\">(\s*<th>.{1,200}</th>){7}\s*</tr>"# , str: htmlContext ?? "")
            
        htmlDataOfChanges = htmlDataOfChanges.map({ (str) in str
                .replacingOccurrences(of: #"<tr class=\"zamena\">\s*<th>&nbsp;</th>"#, with: "", options: .regularExpression)
                .replacingOccurrences(of: #"<th></th>\s*</tr>\s*"#, with: "", options: .regularExpression)
                .replacingOccurrences(of: #"<label><input type=\"checkbox\" class=\"ch_moves\" id=\"lw_\d\" checked=\"checked\" />"#, with: "", options: .regularExpression)
                .replacingOccurrences(of: #"</label></th>"#, with: "", options: .regularExpression)
                
        })
         
        for str in htmlDataOfChanges
        {
            result += searchByRegularExpresion(regularEx: #"<th>\s*(Замен нет|Показать замены)?\s*</th>"#, str: str)
        }
        
        result = result.map({ str in str
                .replacingOccurrences(of: #"<th> Замен нет </th>"#, with: "расписание установленно : замен нет", options: .regularExpression)
                .replacingOccurrences(of: #"<th>  Показать замены </th>"#, with: "расписание установленно : есть замены", options: .regularExpression)
                .replacingOccurrences(of: #"<th> </th>"#, with: "нет точного рассписания", options: .regularExpression)
                
        })
        return result
    }
}

extension Array where Element: StringProtocol {
    func getTotalResult() ->  String {
        var res = ""
        if self.count == 2{
            
            if self[0] == self[1] || self[1] == "empty-pair"{
                res = self[0] as! String
            }
            else{
                
                if self[0] == "empty-pair" {
                    res = self[1] as! String
                }
                else {
                res = self[0] as! String + " / " + self[1]
                }
            }
        }
        else{
            res = self[0] as! String
        }
        return res
    }
}

