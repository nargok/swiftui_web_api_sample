//
//  OkashiData.swift
//  MyOkashi
//
//  Created by 後閑諒一 on 2021/04/29.
//

import Foundation

class OkashiData: ObservableObject {
    
    struct ResultJson: Codable {
        struct Item: Codable {
            let name: String?
            let url: URL?
            let image: URL?
        }
        let item: [Item]?
    }
    
    func searchOkashi(keyword: String) {
        print(keyword)
        
        guard let keyword_encoded = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        guard let req_url = URL(string: "https://www.sysbird.jp/webapi/?apikey=guest&format=json&keyword=\(keyword_encoded)&max=10&order=r")
            else {
                return
        }
        
        print(req_url)
        
        let req = URLRequest(url: req_url)
        
        // データ転送を管理するためのセッションを作成
        let session = URLSession(configuration:.default, delegate: nil, delegateQueue:OperationQueue.main)
        
        // リクエストをタスクとして登録
        let task = session.dataTask(with: req, completionHandler: {
            (data, response, error) in
            
            // セッションを終了
            session.finishTasksAndInvalidate()
            
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ResultJson.self, from: data!)
                
                print(json)
            } catch {
                print("API error!")
            }
        })
        
        // ダウンロード開始
        task.resume()
    }
}
