//
//  AddSubscriptionView.swift
//  SubZero
//
//  Created by Руслан Плешкунов on 10.09.2026.
//

import SwiftUI
import SwiftData

struct AddSubscriptionView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var  price = ""
    @State private var currency = "USD"
    @State private var billingPeriod: BillingPeriod = .monthly
    @State private var nextBillingDate = Date()
    @State private var category: SubscriptionCategory = .other
    var body: some View {
        NavigationStack {
            Form {
                Section("Подписка") {
                    TextField("Name", text: $name)
                    
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                    
                    Picker("Currency", selection: $currency) {
                        Text("EUR").tag("EUR")
                        Text("USD").tag("USD")
                        Text("RUB").tag("RUB")
                    }
                }
                
                Section("Оплата") {
                    Picker("Период", selection: $billingPeriod) {
                        Text("Неделя").tag(BillingPeriod.weekly)
                        Text("Месяц").tag(BillingPeriod.monthly)
                        Text("Год").tag(BillingPeriod.yearly)
                    }
                    
                    DatePicker("Следующий платеж", selection: $nextBillingDate, displayedComponents: .date)
                }
                
                Section("Котегория") {
                    Picker("Категория", selection: $category) {
                        Text("Entertainment").tag(SubscriptionCategory.entertainment)
                        Text("Music").tag(SubscriptionCategory.music)
                        Text("Cloud").tag(SubscriptionCategory.cloud)
                        Text("AI").tag(SubscriptionCategory.AI)
                        Text("Productivity").tag(SubscriptionCategory.productivity)
                        Text("Education").tag(SubscriptionCategory.education)
                        Text("Gaming").tag(SubscriptionCategory.gaming)
                        Text("Fitness").tag(SubscriptionCategory.fitness)
                        Text("Other").tag(SubscriptionCategory.other)
                    }
                }
            }
            .navigationTitle("Добавить подписку")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        saveSubscription()
                    }
                    .disabled(name.isEmpty || price.isEmpty)
                }
            }
        }
    }
    
    private func saveSubscription() {
        guard let priceValue = Double(price.replacingOccurrences(of: ",", with: ".")) else { return }
        let subscription = Subscription (name: name, price: priceValue, currency: currency, billingPeriod: billingPeriod, nextBillingDate: nextBillingDate, category: category)
        modelContext.insert(subscription)
        
        dismiss()
    }
}

#Preview {
    AddSubscriptionView()
}
