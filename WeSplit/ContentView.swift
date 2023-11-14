//
//  ContentView.swift
//  WeSplit
//
//  Created by Shlok Sinha on 14/11/23.
//

import SwiftUI

struct ContentView: View {
    // variable
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFoucs: Bool
    let tipPercentages = [5, 10, 15, 20, 0]
    
    var totalPerPerson: [Double] {
        // calc total per person
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = (checkAmount / 100) * tipSelection
        let grandTotal = Double(checkAmount) + tipValue
        let amountPerPerson = grandTotal / Double(peopleCount)
        
        return [grandTotal, amountPerPerson]
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFoucs)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<101) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Select tip percentage") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total Amount") {
                    Text(totalPerPerson[0], format: .currency(code:
                        Locale.current.currency?.identifier ?? "INR"))
                }
                Section("Amount per person") {
                    Text(totalPerPerson[1], format: .currency(code:
                        Locale.current.currency?.identifier ?? "INR"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFoucs {
                    Button("Done") {
                        amountIsFoucs = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
