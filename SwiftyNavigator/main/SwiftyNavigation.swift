//
//  SwiftyNavigation.swift
//  SwiftyNavigator
//
//  Created by Yinsheng Dong on 2022-03-18.
//

import SwiftUI

@available(iOS 14, *)
@available(macOS 10.15, *)
public struct SwiftyNavigation<Content: View>: View {
    let content: () -> Content
    
    @EnvironmentObject public var manager: SwiftyNavigationManager
    @Environment(\.presentationMode) var presentationMode
    
    public var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(isActive: $manager.isPresented, destination: manager.destination) {
                    EmptyView()
                }
                content()
            }
            .onReceive(manager.$isDismiss) { isDismiss in
                if isDismiss {
                    presentationMode.wrappedValue.dismiss()
                    manager.isDismiss = false
                }
            }
        }
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}


