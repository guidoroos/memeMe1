//
//  test.swift
//  MemeMe1
//
//  Created by Guido Roos on 19/06/2023.
//

import Foundation
import SwiftUI

struct ContentView2: View {
    init() {
        UIToolbar.changeAppearance(color: UIColor.gray.withAlphaComponent(0.1)
        )
    }
    
    var body: some View {
        NavigationStack {
            VStack {
            
                    Text("Hello, world!")

            }
            .toolbar {
                HomeToolbar()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            .padding()
        }
    }
}

struct HomeToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Text("Home")
        }

        ToolbarItem(placement: .principal) {
            Image(systemName: "bus")
        }

        ToolbarItem(placement: .bottomBar) {
            Button("Save") {
                print("delete document")
            }.buttonStyle(.borderedProminent)
        }
    }
}
