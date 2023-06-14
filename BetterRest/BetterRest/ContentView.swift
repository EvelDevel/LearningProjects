//
//  ContentView.swift
//  BetterRest
//
//  Created by Евгений Никитин on 14.06.2023.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                HStack(spacing: 0) {
                    Text("Wake up time")
                    
                    Spacer()
                    
                    DatePicker(
                        "Please enter a time",
                        selection: $wakeUp,
                        displayedComponents: .hourAndMinute
                    )
                    .labelsHidden()
                }
                .padding(4)
                
                Section("Amount of sleep") {
                    Stepper(
                        "\(sleepAmount.formatted()) hours",
                        value: $sleepAmount,
                        in: 4...12,
                        step: 0.25
                    )
                    .padding(4)
                }
                
                Section("Coffe intake") {
                    Picker(
                        coffeeAmount == 0 ? "1 cup" : "\(coffeeAmount) cups",
                        selection: $coffeeAmount
                    ) {
                        ForEach(1 ..< 20) { number in
                            let cup = number == 1 ? "cup" : "cups"
                            Text("\(number) \(cup)")
                        }
                    }
                    .padding(4)
                }
                
                Section("Your ideal bedtime is...") {
                    Text(
                        calculateBedTime()
                    )
                    .padding(8)
                    .font(.headline)
                }
            }
            .navigationTitle("BetterRest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func calculateBedTime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents(
                [.hour, .minute],
                from: wakeUp
            )
            
            // Number of hours and minutes in seconds
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            // Make prediction
            let prediction = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount + 1)
            )
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(
                date: .omitted,
                time: .shortened
            )
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
            showingAlert = true
        }
        
        return ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
