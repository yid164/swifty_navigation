//
//  ContentView.swift
//  Examples
//
//  Created by Yinsheng Dong on 2022-03-18.
//

import SwiftUI
import SwiftyNavigator

struct ContentView: View {
    
    @StateObject var manager = SwiftyNavigationManager()
    @State var text: String = ""
    
    var body: some View {
        
        SwiftyNavigation {
            Button(action: {
                manager.naigateTo(des: Subview(text: "Boring", manager: manager))
            }) {
                Text("Boring")
//                Subview(text: "Boring")
            }
        }
        .environmentObject(manager)
    }
}

struct Subview: View {
    var text: String
    @ObservedObject var manager: SwiftyNavigationManager
    
    var body: some View {
        Button(action: { manager.dismiss() }) {
            Text(text)
        }
        
    }
}

let fruits: [String] = [
    "Apple",
    "Banana",
    "Orange",
    "Pineapple",
]

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
