//
//  ContentView.swift
//  multiMessager
//
//  Created by Jordan Davis on 2023-02-12.
//

import SwiftUI
import Foundation
import Contacts

struct ContentView: View, CNContactPickerDelegate {
    @State private var messages = ""
    @State private var names = ""
    @State private var selectedContacts = [CNContact]()
    
    var body: some View {
        let offWhite = Color(red: 0.95, green: 0.95, blue: 0.95)
        let luxuryBackground = Color(red: 0.9, green: 0.9, blue: 0.9)
        let offBlack = Color(red: 0.1, green: 0.1, blue: 0.1)
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.1)
                    .edgesIgnoringSafeArea(.all)
                    .ignoresSafeArea(.keyboard)
            VStack {
                HStack {
                    Image(systemName: "message.fill")
                        .foregroundColor(offWhite)
                    Text("Message Sender")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding()
                
                TextEditor(text: $messages)
                    .textFieldStyling()
                    .frame(height: 200, alignment: .topLeading)
                    .onAppear {
                        self.messages = "Enter messages separated by new lines, Use XXXX where you want a name to go."
                        }
                    .onTapGesture {
                        if self.messages == "Enter messages separated by new lines, Use XXXX where you want a name to go." {
                            self.messages = ""
                        }
                    }

                TextEditor(text: $names)
                    .textFieldStyling()
                    .onAppear {
                        self.names = "Enter names, separated by commas"
                    }
                    .onTapGesture {
                        if self.names == "Enter names, separated by commas" {
                            self.names = ""
                        }
                    }

                Spacer()

                VStack(alignment: .center) {
                    Text("Messages to send :)")
                        .font(.headline)
                        .foregroundColor(offWhite)
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(processInputs(messages: messages, names: names), id: \.self) { output in
                                Text(output)
                                    .foregroundColor(offBlack)
                                    .contextMenu {
                                        Button(action: {
                                            UIPasteboard.general.string = output
                                        }) {
                                            Label("Copy", systemImage: "doc.on.doc")
                                        }
                                    }
                            }
                        }
                    }
                    .frame(width: 350, height: 300)
                    .padding()
                    .background(luxuryBackground)
                    .cornerRadius(20.0)
                    .shadow(radius: 10)
                    
                }
                
            }
        }.gesture(DragGesture().onChanged({ _ in // Dismisses the keyboard when the user taps outside of the text editor
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }))
    }
    
    func processInputs(messages: String, names: String) ->  [String]{
        let messageArray = messages.components(separatedBy: .newlines);
        let nameArray = names.components(separatedBy: ",");
        
        var returnMessages = [String]();
        
        for name in nameArray{
            if(messageArray.count > 0){
                let randNum = Int.random(in: 0..<messageArray.count)
                let message = messageArray[randNum]
                let finalM = message.replacingOccurrences(of: "XXXX", with: name)
                returnMessages.append(finalM)
            }else {
                returnMessages.append("No messages available")
            }
            
        }
        return returnMessages
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



