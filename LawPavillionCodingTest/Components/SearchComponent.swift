//
//  SearchComponent.swift
//  LawPavillionCodingTest
//
//  Created by Patrick Chikamso on 5/11/22.
//

import SwiftUI

struct SearchComponent: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            TextField("Search Query", text: $viewModel.searchQuery).padding().background(
                RoundedRectangle(cornerRadius: 8).stroke(Color.black)
            )
            ZStack {
                if self.viewModel.loading {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.green))
                } else {
                    Button(action: {
                        if !self.viewModel.searchQuery.isEmpty {
                            self.viewModel.initiateSearch()
                        }
                    }, label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .foregroundColor(self.viewModel.searchQuery.isEmpty ? Color.gray : Color.green)
                            .font(.system(size: 32, weight: .medium))
                    })
                }
            }
        }
    }
}

struct SearchComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchComponent(viewModel: ViewModel())
        }
    }
}
