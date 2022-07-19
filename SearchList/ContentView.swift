//
//  ContentView.swift
//  SearchList
//
//  Created by Ardian Pramudya Alphita on 19/07/22.
//

import SwiftUI

struct Fruit: Identifiable, Equatable {
    var id: UUID
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

struct ContentView: View {
    
    var fruitList = [
        Fruit(name: "Durian"),
        Fruit(name: "Mangga"),
        Fruit(name: "Apple"),
        Fruit(name: "Melon"),
        Fruit(name: "Semangka")
    ]
    @State var searchText = ""
    var filteredFruit: [Fruit] {
        if searchText.isEmpty {
            return fruitList
        } else {
            return fruitList.filter { fruit in
                fruit.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    @Namespace var animation
    
    var horizontalList: some View {
        Group {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 24) {
                    ForEach(filteredFruit) { fruit in
                        ZStack {
                            Text(fruit.name)
                        }
                        .frame(width: 285, height: UIScreen.main.bounds.height / 1.75)
                        .background(Color.gray)
                        .cornerRadius(10)
                        .matchedGeometryEffect(id: fruit.id, in: animation)
                    }
                }
                .padding(.leading)
            }
        }
    }
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    var gridList: some View {
        Group {
            ScrollView {
                LazyVGrid(columns: twoColumnGrid) {
                    ForEach(filteredFruit) { fruit in
                        ZStack {
                            Text(fruit.name)
                        }
                        .frame(
                            width: UIScreen.main.bounds.width / 2.25,
                            height: 170
                        )
                        .background(Color.gray)
                        .cornerRadius(10)
                        .matchedGeometryEffect(id: fruit.id, in: animation)
                    }
                }
            }
        }
    }
    
    @State var isChangeListToggle = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Cari", text: $searchText)
                }
                .padding()
                .frame(height: 42)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()
                if isChangeListToggle {
                    gridList
                        .padding(.horizontal)
                } else {
                    Spacer()
                    horizontalList
                    Spacer()
                }
            }
            .navigationTitle("Cari Buah")
            .toolbar {
                Button {
                    withAnimation(.spring()) {
                        isChangeListToggle.toggle()
                    }
                } label: {
                    Image(systemName: isChangeListToggle ? "list.dash" : "square.grid.2x2")
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
