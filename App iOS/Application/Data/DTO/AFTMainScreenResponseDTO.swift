//
//  AFTMainScreenResponseDTO.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 28/11/22.
//

import Foundation

struct AFTMainScreenResponseDTO: Decodable {
    let name: String?
    let address: String?
    let minOrder: Decimal?
    let openTill: String?
    let distance: Double?
    let previousOrders: [PreviousOrder]
    let menu: Menu
    
    func toDomain() -> AFTMainScreenData {
        let deliveryDetails = AFTDeliveryDetails(address: address, minOrderPrice: minOrder, openTill: openTill, distance: distance)
        let prevOrders: [AFTRecentOrder] = previousOrders.map({ .init(title: $0.items, price: $0.price) })
        let menu: [AFTProductSecion] = menu.sections.map({
            return AFTProductSecion(name: $0.name,
                             description: $0.description,
                                    items: $0.items.map({ AFTProduct(id: UUID(), name: $0.name, description: $0.description, price: $0.price, image: $0.image)
            }))
        })
        let data = AFTMainScreenData(deliveryDetails: deliveryDetails, recentOrders: prevOrders, menu: menu)
        return data
    }
}

extension AFTMainScreenResponseDTO {
    struct PreviousOrder: Decodable {
        let items: [String]
        let price: Decimal
    }
}

extension AFTMainScreenResponseDTO {
    struct Menu: Decodable {
        let sections: [Section]
    }
}


extension AFTMainScreenResponseDTO.Menu {
    struct Section: Decodable {
        let name: String?
        let description: String?
        let items: [Product]
    }
}

extension AFTMainScreenResponseDTO.Menu.Section {
    struct Product: Decodable {
        let name: String?
        let description: String?
        let price: Decimal?
        let image: URL?
    }
}
