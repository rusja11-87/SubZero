//
//  ContentView.swift
//  SubZero
//
//  Created by Руслан Плешкунов on 10.09.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showingAddSubscription = false
    @Query private var subscriptions: [Subscription]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                // MARK: - Total
                
                VStack(spacing: 8) {
                    Text("Ежемесячные расходы")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text(monthlySpending, format: .currency(code: "USD"))
                        .font(.system(size: 42, weight: .bold))
                    
                    Text("\(subscriptions.count) подписок")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 32)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                
                // MARK: - Upcoming
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Предстоящие")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    if subscriptions.isEmpty {
                        ContentUnavailableView("Подписок нет", systemImage: "calendar.badge.plus", description: Text("Добавь свою первую подписку"))
                    } else {
                        ForEach(subscriptions) { subscription in
                            SubscriptionRow(subscription: subscription)
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("SubZero")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddSubscription = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSubscription) {
                AddSubscriptionView()
            }
        }
    }
    
    private var monthlySpending: Double {
        subscriptions
        //  .filter { $0.isActive }
            .reduce(0) { total, subscription in
                switch subscription.billingPeriod {
                case .weekly:
                    return total + subscription.price * 52 / 12
                case .monthly:
                    return total + subscription.price
                case .yearly:
                    return total + subscription.price / 12
                }
            }
    }
    
}

// MARK: - SubscriptionRow

struct SubscriptionRow: View {
    let subscription: Subscription
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: subscription.iconName ?? "app.fill")
                .font(.title2)
                .frame(width: 44, height: 44)
                .background(.gray.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(subscription.name)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                Text(subscription.nextBillingDate, style: .relative)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(subscription.price, format: .currency(code: subscription.currency))
                .fontWeight(.semibold)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Subscription.self, inMemory: true)
}
