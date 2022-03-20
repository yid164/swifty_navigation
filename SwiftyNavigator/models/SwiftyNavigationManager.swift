//
//  SwiftyNavigationManager.swift
//  SwiftyNavigator
//
//  Created by Yinsheng Dong on 2022-03-19.
//

import Foundation
import SwiftUI

@available(macOS 10.15, *)
@available(iOS 14, *)
public class SwiftyNavigationManager: ObservableObject {
    
    @Published var isPresented: Bool = false
    
    @Published var destination: () -> AnyView
    
    @Published var isDismiss: Bool = false
    
    @Published var currentView: AnyView? = nil
    
    @Published var viewLinkedList: LinkedList<AnyView> = LinkedList<AnyView>()
    
    public func push() {}
    
    public func pushAndReplace() {}
    
    public func pop() {}
    
    public func popUntil() {}
    
    public func popToRoot() {}
    
    public func navigate<Content: View>(@ViewBuilder des: () -> Content) {
        self.isPresented = true
        let desn = des()
        self.destination = { desn.wrappToAnyView }
    }
    
    public func naigateTo<Content: View>(des: Content) {
        self.isPresented = true
        let desn = des
        self.destination = { desn.wrappToAnyView }
    }
    
    public func dismiss() {
        self.isDismiss = true
        self.isPresented = false
    }
    
    // Data
    public func viewIndexAt(indexAt index: Int) {}
    
    public func removeIndexAt(indexAt index: Int) {}
    
    
    
    public init() {
        destination = { EmptyView().wrappToAnyView }
    }
}

@available(macOS 10.15, *)
@available(iOS 14, *)
extension View {
    var wrappToAnyView: AnyView {
        AnyView(self)
    }
}
