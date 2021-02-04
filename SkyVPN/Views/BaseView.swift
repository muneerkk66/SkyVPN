//
//  BaseView.swift
//  SkyVPN
//
//  Created by x218507 on 04/02/21.
//

import SwiftUI
//MARK:- Base view is used to support common features through all the views
// Eg: Keyboard hide,Alerts etc
struct BaseView<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color.white
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(content)
    }
}
