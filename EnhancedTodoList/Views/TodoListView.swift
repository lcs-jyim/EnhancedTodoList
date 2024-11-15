//
//  TodoListView.swift
//  EnhancedTodoList
//
//  Created by junxi Yim on 2024/11/13.
//

import SwiftUI

struct TodoListView: View {
    
    // MARK: Stored properties
    
    // Our list of items to complete
    @State private var items: [TodoItem] = []
    // The item currently being created
    @State private var newItemDetails = ""
    
    // MARK: Computed properties
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    
                    TextField("Enter a to-do item", text: $newItemDetails)
                    
                    Button("Add") {
                        addItem()
                    }
                 
                }
                .padding(20)
                    
                    if items.isEmpty {
                        
                        ContentUnavailableView(label: {
                            Label(
                                "Nothing to do",
                                systemImage: "powersleep"
                            )
                            .foregroundStyle(.green)
                        }, description: {
                            Text("To-do items will appear here once you add some.")
                        })
                        
                    } else {
                        
                        List(items) { currentItem in
                            Label {
                                Text(currentItem.details)
                            } icon: {
                                Image(systemName: currentItem.isCompleted ? "checkmark.circle" : "circle")
                            }
                        }
                        
                
                }
            }
            .navigationTitle("Tasks")
        }
        .onAppear {
            // Populate with example data
            if items.isEmpty {
                items.append(contentsOf: exampleData)
            }
        }
    }
    
    // MARK: Functions
    func addItem() {
        let newToDoItem = TodoItem(details: newItemDetails)
        items.insert(newToDoItem, at: 0)
        newItemDetails = ""
    }
    
}

#Preview {
    TodoListView()
}
