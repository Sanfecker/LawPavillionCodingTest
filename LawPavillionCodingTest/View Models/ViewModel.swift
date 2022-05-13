//
//  ViewModel.swift
//  LawPavillionCodingTest
//
//  Created by Patrick Chikamso on 5/11/22.
//

import Foundation


class ViewModel: ObservableObject {
    // List of items
    @Published var itemList: [Item] = []
    
    @Published var selectedItem: Item?
    
    // Loading state
    @Published var loading: Bool = false
    
    // search text
    @Published var searchQuery: String = ""
    
    // page control
    @Published var page: Int = 1 {
        didSet {
            if self.page == 1 {
                self.emptyItems()
            }
            
            self.getItems()
        }
    }
    
    func initiateSearch() {
        self.resetPageControl()
    }
    
    func resetPageControl() {
        self.page = 1
    }
    
    func emptyItems() {
        self.itemList = [Item]()
    }
    
    func addNextPage() {
        self.page += 1
    }
    
    func loadMoreContent(currentItem item: Item) {
        let itemIndex = self.itemList.index(self.itemList.endIndex, offsetBy: -1)
        if itemList[itemIndex].login == item.login {
            self.addNextPage()
        }
    }
    
    func getItems() {
        self.loading = true
        
        // add search query to params
        var params: [String: String] = ["q": self.searchQuery]
        
        // number of items to return per page
        params["per_page"] = "10"
        
        // page number
        params["page"] = String(self.page)
        
        guard let url = NSURLComponents(string: "https://api.github.com/search/users") else {
            print("url not valid")
            return
        }
        
        var items = [URLQueryItem]()

        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }

        items = items.filter{!$0.name.isEmpty}

        if !items.isEmpty {
          url.queryItems = items
        }
        
        let request = URLRequest(url: url.url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    if let data = data {
                        if let decodedResponse = try? JSONDecoder().decode(DataModel.self, from: data) {
                            DispatchQueue.main.async {
                                self.itemList += decodedResponse.items.sorted { $0.login.lowercased() < $1.login.lowercased() }
                            }
                        } else {
                            print("Decode failed")
                        }
                    }
                }
                if statusCode == 304 {
                    print("Not modified")
                }
                if statusCode == 422 {
                    print("Validation failed")
                }
                if statusCode == 503 {
                    print("Service unavailable")
                }
                
                DispatchQueue.main.async {
                    self.loading = false
                }
            }
        }.resume()
    }
}
