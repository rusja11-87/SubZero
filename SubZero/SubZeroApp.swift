//
//  SubZeroApp.swift
//  SubZero
//
//  Created by Руслан Плешкунов on 10.09.2026.
//

import SwiftUI
import SwiftData

@main
struct SubZeroApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Subscription.self)
    }
}
