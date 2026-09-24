//
//  Subscription.swift
//  SubZero
//
//  Created by Руслан Плешкунов on 10.09.2026.
//

import Foundation
import SwiftData

@Model
final class Subscription {
    var id: UUID
    var name: String
    var price: Double
    var currency: String
    var billingPeriod: BillingPeriod
    var nextBillingDate: Date
    var category: SubscriptionCategory
    var reminderDays: Int
    var isactive: Bool
    var iconName: String?
    
    init(name: String, price: Double, currency: String = "USD", billingPeriod: BillingPeriod, nextBillingDate: Date, category: SubscriptionCategory, reminderDays: Int = 3, iconName: String? = nil) {
        self.id = UUID()
        self.name = name
        self.price = price
        self.currency = currency
        self.billingPeriod = billingPeriod
        self.nextBillingDate = nextBillingDate
        self.category = category
        self.reminderDays = reminderDays
        self.isactive = true
        self.iconName = iconName
    }
}

enum BillingPeriod: String, Codable {
    case weekly
    case monthly
    case yearly
}

enum SubscriptionCategory: String, Codable {
    case entertainment
    case music
    case cloud
    case AI
    case productivity
    case education
    case gaming
    case fitness
    case other
}
