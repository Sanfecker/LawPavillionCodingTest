//
//  ItemCard.swift
//  LawPavillionCodingTest
//
//  Created by Patrick Chikamso on 5/11/22.
//

import SwiftUI

struct ItemCard: View {
    var item: Item
    
    var body: some View {
        HStack (alignment: .center, spacing: 16) {
            RemoteImage(url: item.avatar_url)
                .scaledToFill()
                .frame(width: 44, height: 44, alignment: .center)
                .cornerRadius(22)
                .padding(4)
                .background(Circle().fill(Color.gray.opacity(0.1)))
            VStack (alignment: .leading, spacing: 8) {
                Text(item.login).font(.headline)
                Text(item.type).font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
        }.padding().background(
            RoundedRectangle(cornerRadius: 8).fill(Color.white).shadow(color: .black.opacity(0.2), radius: 2, y: 1)
        )
    }
}

struct ItemCard_Previews: PreviewProvider {
    static var previews: some View {
        ItemCard(item: Item(login: "Patrick Uchegbu", avatar_url: "", type: "User"))
    }
}
