//
//  ContentView.swift
//  level1Project
//
//  Created by Hitesh Parikh on 3/28/22.
//

import SwiftUI

struct ContentView: View {
    @State private var userInput: String = ""
    @State private var optionsList: [String] =  [String]()
    @State private var showingAlert = false
    @State private var showingAlert2 = false
    @FocusState private var isFieldFocused: Bool
    @State private var alertMessage: String = "Another random choice"


    var body: some View {
        
        VStack{
            List {
                Section{
                    
                    TextField("Option \(optionsList.count+1)", text: $userInput, onCommit: {
                        isFieldFocused = true
                        //                    print("onCommit")
                    })
                        .onSubmit({
                            if userInput != "" {
                                optionsList.append(userInput)
                                userInput=""
                            }
                            else {
                                showingAlert2 = true
                            }
                        })
                        .focused($isFieldFocused)
                        .alert("Please enter some text", isPresented: $showingAlert2){
                            Button("OK") {}
                        }
                }
                Section {
                    ForEach(optionsList, id: \.self) { word in
                        Text(word)
      
                    } .onDelete(perform: delete)

                    
                }
            }
            
        }
        Button("Show Magic Choice 4") {
            showingAlert = true
            alertMessage = optionsList.randomElement() ?? "please enter choices"
            
        }
        //        .alert(optionsList.randomElement() ?? "Please enter choices", isPresented: $showingAlert) {
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("reset", role:.destructive) { optionsList.removeAll()}

            //            Button("one", action: {})
            Button("Roll again", action: {
                showingAlert = false
                showingAlert = true

                alertMessage = optionsList.randomElement() ?? "please enter choices"
            })
            Button("three", role: .destructive, action: {})
            Button("four", role: .cancel, action: {})
            
        }
    }
    func delete(at offsets: IndexSet) {
        optionsList.remove(atOffsets: offsets)
    }
    
    
}


  
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
