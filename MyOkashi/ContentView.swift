//
//  ContentView.swift
//  MyOkashi
//
//  Created by 後閑諒一 on 2021/04/29.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var okashiDataList = OkashiData()
    
    @State var inputText = ""
    
    
    var body: some View {
        
        TextField("キーワードを入力してください", text: $inputText, onCommit: {
            okashiDataList.searchOkashi(keyword: inputText)
        })        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
