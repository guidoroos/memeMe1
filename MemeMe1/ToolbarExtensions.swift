//
//  ToolbarExtensions.swift
//  MemeMe1
//
//  Created by Guido Roos on 18/06/2023.
//

import SwiftUI

extension UIToolbar {
    static func changeAppearance(color:UIColor) {
        let toolbarAppearance = UIToolbarAppearance()
        
        // customize appearance for your needs here
        toolbarAppearance.backgroundColor = color
 
        
        UIToolbar.appearance().standardAppearance = toolbarAppearance
        UIToolbar.appearance().compactAppearance = toolbarAppearance
        UIToolbar.appearance().scrollEdgeAppearance = toolbarAppearance
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = color
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
}
