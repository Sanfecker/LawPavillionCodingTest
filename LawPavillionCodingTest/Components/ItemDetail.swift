//
//  ItemDetail.swift
//  LawPavillionCodingTest
//
//  Created by Patrick Chikamso on 5/11/22.
//

import SwiftUI

struct ItemDetail: View {
    @ObservedObject var viewModel: ViewModel
    
    var item: Item {
        self.viewModel.selectedItem ?? Item(login: "", avatar_url: "", type: "")
    }
    
    var body: some View {
        VStack (alignment: .center, spacing: 16) {
            RemoteImage(url: item.avatar_url)
                .scaledToFill()
                .frame(width: 120, height: 120, alignment: .center)
                .cornerRadius(60)
                .padding(4)
                .background(Circle().fill(Color.gray.opacity(0.1)))
            Text(item.login).font(.headline)
            Text(item.type).font(.subheadline).foregroundColor(.gray)
        }.padding()
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetail(viewModel: ViewModel())
    }
}
