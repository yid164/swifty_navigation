//
//  SwifyNavigation.swift
//  SwiftyNavigator
//
//  Created by Yinsheng Dong on 2022-03-18.
//

import SwiftUI

public struct SwifyNavigation<Content: View>: View {
    let content: () -> Content
    
    @EnvironmentObject public var manager: SwiftyNavigationManager
    
    public var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(isActive: $manager.isPresented, destination: manager.destination) {
                    EmptyView()
                }
                content()
            }
        }
    }
    
    public init(_ content: @escaping () -> Content) {
        self.content = content
    }
}

public class SwiftyNavigationManager: ObservableObject {
    
    @Published var isPresented: Bool = false
    
    @Published var destination: () -> AnyView

    
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
    
    public init() {
        destination = { EmptyView().wrappToAnyView }
    }
}

extension View {
    var wrappToAnyView: AnyView {
        AnyView(self)
    }
}
