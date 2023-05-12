//
//  ViewMemo.swift
//  TaskWatch Watch App
//
//  Created by Robotics on 11/5/2023.
//

import SwiftUI
import CoreData

struct ViewMemo: View {
    // Core Data Fetch Request...
    
    // Were getting Memos At descending order by using adder or modified date...
    @FetchRequest(entity: Memo.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Memo.dateAdded,
                                                     ascending: false)],
                  animation: .easeIn) var results: FetchedResults<Memo>
    
    var body: some View {
        List(results) { item in
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(item.title ?? "")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                    
                    Text("Last Modified")
                        .font(.system(size: 8))
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                    
                    Text(item.dateAdded ?? Date(), style: .date)
                        .font(.system(size: 8))
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 4)
                
                //Edit Button
                NavigationLink {
                    AddItem(memoItem: item)
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(.orange)
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
        .navigationTitle("Memo's")
    }
}
