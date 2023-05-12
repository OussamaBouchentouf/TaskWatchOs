//
//  AddItem.swift
//  TaskWatch Watch App
//
//  Created by Robotics on 11/5/2023.
//

import SwiftUI

struct AddItem: View {
    @State private var memoText: String = ""
    
    // getting context from environment...
    @Environment(\.managedObjectContext) var context
    
    //Dismiss...
    @Environment(\.dismiss) var dismiss
    
    // Edit Option...
    var memoItem: Memo? 
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("Memories...", text: $memoText)
            
            Button {
                addMemo()
            } label: {
                Text("Save")
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(.orange)
                    .cornerRadius(15)
            }
            .padding(.horizontal)
            .buttonStyle(PlainButtonStyle())
            .disabled(memoText == "")
        }
        .navigationTitle(memoItem == nil ? "Add Memo" : "Edit Memo")
        .onAppear {
            // Verifying if memo item has data...
            if let memoItem = memoItem {
                memoText = memoItem.title ?? ""
            }
        }
    }
    
    // Adding Memo...
    func addMemo() {
        let memo = memoItem == nil ? Memo(context: context) : memoItem!
        memo.title = memoText
        memo.dateAdded = Date()
        
        // Saving...
        do {
            try context.save()
            // if success...
            // closing view
            dismiss()
        } catch {
            print("Unable to save memo with err description: \(error.localizedDescription)")
        }
    }
}
