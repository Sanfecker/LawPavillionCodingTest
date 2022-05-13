//
//  ContentView.swift
//  LawPavillionCodingTest
//
//  Created by Patrick Chikamso on 5/11/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel = ViewModel()
    
    @State var showSheet: Bool = false
    
    let sheetHeight = UIScreen.main.bounds.height * 0.5
    
    var body: some View {
        ZStack {
            VStack {
                SearchComponent(viewModel: self.viewModel)
                ScrollView {
                    LazyVStack (spacing: 16) {
                        ForEach(self.viewModel.itemList, id: \.self) { item in
                            ItemCard(item: item).onTapGesture {
                                self.viewModel.selectedItem = item
                                self.showSheet = true
                            }.onAppear {
                                self.viewModel.loadMoreContent(currentItem: item)
                            }
                        }
                    }
                }
            }.padding()
            BottomSheetView(isShown: $showSheet, modalHeight: sheetHeight, ignoresBottomSafeArea: false, content: {
                ItemDetail(viewModel: self.viewModel)
            }, color: .white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
