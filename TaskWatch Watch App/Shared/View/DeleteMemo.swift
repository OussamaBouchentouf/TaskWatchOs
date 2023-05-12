//
//  DeleteMemo.swift
//  TaskWatch Watch App
//
//  Created by Robotics on 11/5/2023.
//

import SwiftUI

struct DeleteMemo: View {
    @FetchRequest(entity: Memo.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Memo.dateAdded,
                                                     ascending: false)],
                  animation: .easeIn) var results: FetchedResults<Memo>
    
    @State var deleteMemoItem: Memo?
    @State var deleteMemo: Bool = false
    
    // Context...
    @Environment(\.managedObjectContext) var context
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List(results) { item in
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(item.title ?? "")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                     
                    Text(item.dateAdded ?? Date(), style: .date)
                        .font(.system(size: 8))
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 4)
                
                //Edit Button
                Button {
                    // storing current Memo...
                    deleteMemoItem = item
                    withAnimation(.easeInOut) {
                        deleteMemo.toggle()
                    }
                } label: {
                    Image(systemName: "trash")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(.red)
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .listStyle(CarouselListStyle())
        .padding(3)
        .overlay {
            Text(results.isEmpty ? "No Memo's found" : "")
        }
        .navigationTitle("Delete Memo")
        .alert(isPresented: $deleteMemo) {
            Alert(title: Text("Confirm"), message: Text("To delete this Memo?"), primaryButton: .destructive(Text("Ok"), action: {
                deleteMemo(memo: deleteMemoItem!)
            }), secondaryButton: .default(Text("Cancel")))
        }
    }
    
    // Delete Memo...
    func deleteMemo(memo: Memo) {
        context.delete(memo)
        
        do {
            try context.save()
        } catch {
            print("Cannot delete following memo error: \(error.localizedDescription)")
        }
    }
}
