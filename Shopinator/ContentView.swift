//
//  ContentView.swift
//  Shopinator
//
//  Created by Mostafa Ahmed on 08/05/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            Text("Cards")
                .tabItem {
                    Image(systemName: "creditcard.fill")
                    Text("Cards")
                }

            Text("Transfers")
                .tabItem {
                    Image(systemName: "arrow.left.arrow.right")
                    Text("Transfers")
                }

            Text("More")
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
        }.accentColor(Color(hue: 0.75, saturation: 0.7, brightness: 0.8))
    }
}

struct HomeView: View {
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // First section (Header)
                    HStack {
                        Circle()
                            .fill(Color.purple.opacity(0.7))
                            .frame(width: 40, height: 40)
                            .overlay(Text("MS").foregroundColor(.white).bold())
                        Text("Hello, Mostafa")
                            .font(.title2)
                            .bold()
                        Spacer()
                        Image(systemName: "bell")
                            .font(.title3)
                    }
                    .padding([.horizontal, .top])

                    // Total Balance Section
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Total balance")
                            .font(.caption)
                        Text("$8 600")
                            .font(.system(size: 47, weight: .bold))
                            .bold()
                    }
                    .padding([.horizontal])

                    // Cards Section
                    VStack(alignment: .leading) {
                        HStack {
                            Text("CARDS")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(Color.gray)
                            Spacer()
                            Text("Add +")
                                .foregroundColor(.purple)
                                .font(.subheadline)
                        }

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                CardView(title: "Salary", amount: "$2 230", color: Color.purple.opacity(0.7), last4: "6917", expiry: "01/04")
                                CardView(title: "Credit card", amount: "$5 230", color: Color.black.opacity(0.8), last4: "4433", expiry: "02/04")
                                CardView(title: "Credit", amount: "$980", color: Color.pink.opacity(0.7), last4: "1788", expiry: "03/04")
                            }
                            .padding(.top, 4)
                        }
                    }
                    .padding([.horizontal])

                    // Finance Section
                    VStack(alignment: .leading) {
                        Text("FINANCE")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(Color.gray)
                        
                        // Horizontal ScrollView
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                FinanceItem(title: "My bonuses", icon: "star", color: .purple)
                                FinanceItem(title: "Finance analysis", icon: "chart.bar", color: .cyan)
                                FinanceItem(title: "Payment", icon: "doc.text", color: .indigo)
                                FinanceItem(title: "Invest", icon: "arrow.up.right", color: .pink)
                            }
                        }
                    }
                    .padding([.horizontal])

                    // Last Transactions Section (No padding here, background extends full width)
                    ZStack {
                        Color.gray.opacity(0.1)
                            .edgesIgnoringSafeArea(.horizontal)  // Full width background

                        VStack(alignment: .leading) {
                            HStack {
                                Text("LAST TRANSACTIONS")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(Color.gray)
                                Spacer()
                                Text("See all >")
                                    .foregroundColor(.purple)
                                    .font(.subheadline)
                            }

                            TransactionItem(title: "Supermarket", time: "Today, 16:40", amount: "-40$", type: .payment)
                            TransactionItem(title: "Kapital Bank", time: "Today, 12:30", amount: "+20$", type: .transfer)
                        }
                        .padding()
                    }
                }
            }
            // Add the spotlight effect at the top center of the screen
            VStack {
                Spacer()
                Circle()
                    .fill(Color.purple.opacity(0.15))
                    .frame(width: 360, height: 320)
                    .position(x: UIScreen.main.bounds.width / 2, y: 40)  // Position near the notch
                    .blur(radius: 28)
            }.ignoresSafeArea()
        }
    }
}





struct CardView: View {
    let title: String
    let amount: String
    let color: Color
    let last4: String
    let expiry: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("VISA")
                .font(.headline)
                .foregroundColor(.white)
            Text(title)
                .foregroundColor(.white)
            Text(amount)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            Spacer()
            HStack {
                Text("** \(last4)")
                Spacer()
                Text(expiry)
            }
            .foregroundColor(.white.opacity(0.8))
            .font(.caption)
        }
        .padding()
        .frame(width: 160, height: 150)
        .background(color)
        .cornerRadius(16)
    }
}

struct FinanceItem: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Main container
            VStack {
                Spacer()
                HStack{
                    Text(title)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(CGFloat.init(16))
                    Spacer()
                }
            }
            .frame(width: 110, height: 110)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            // Icon container in the top-left corner
            Rectangle()
                .fill(color)
                .frame(width: 38, height: 38)
                .cornerRadius(4)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                )
                .padding(10)
        }
    }
}


enum TransactionType {
    case payment, transfer
}

struct TransactionItem: View {
    let title: String
    let time: String
    let amount: String
    let type: TransactionType

    var body: some View {
        HStack {
            Image(systemName: type == .payment ? "cart.fill" : "arrow.down.circle.fill")
                .foregroundColor(.white)
                .padding(15)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                Text(time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack{
                Text(amount)
                    .foregroundColor(type == .payment ? .black : .green)
                    .bold()
                Text("Payment")
                    .font(.caption2)
                    .foregroundColor(Color.gray.opacity(0.9))
            }
        }
        .padding(.vertical, 8)
        .frame(height: 70)
    }
}


#Preview {
    ContentView()
}
