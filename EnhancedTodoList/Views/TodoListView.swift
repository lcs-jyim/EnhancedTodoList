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
    @State private var searchText = ""
    
    // MARK: Computed properties
    var filteredItems: [TodoItem] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { item in
                item.details.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
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
                
                if filteredItems.isEmpty {
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
                    List {
                        ForEach(filteredItems) { currentItem in
                            Label {
                                Text(currentItem.details)
                            } icon: {
                                Image(systemName: currentItem.isCompleted ? "checkmark.circle" : "circle")
                                    .onTapGesture {
                                        toggle(item: currentItem)
                                    }
                            }
                        }
                        .onDelete(perform: delItem)
                    }
                }
            }
            .navigationTitle("Tasks")
            .searchable(text: $searchText)
            .onAppear {
                // Populate with example data
                if items.isEmpty {
                    items.append(contentsOf: exampleData)
                }
            }
        }
    }
    
    // MARK: Functions
    func addItem() {
        let newToDoItem = TodoItem(details: newItemDetails)
        items.insert(newToDoItem, at: 0)
        newItemDetails = ""
    }
    
    func toggle(item: TodoItem) {
        if item.isCompleted {
            item.completedOn = nil
            item.isCompleted = false
        } else {
            item.completedOn = Date()
            item.isCompleted = true
        }
    }
    
    func delItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

#Preview {
    TodoListView()
}
