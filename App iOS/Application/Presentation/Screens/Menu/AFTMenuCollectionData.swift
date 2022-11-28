//
//  AFTMenuCollectionData.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 28/11/22.
//

import Foundation

class AFTMenuCollectionData: Equatable, Hashable {
    
    enum `Type` {
        case sectionHeader
        case product
    }
    
    class SectionHeader: Equatable, Hashable {
        let id: UUID
        let title : String
        let description : String?
        
        init(id: UUID, title: String, description: String?) {
            self.id = id
            self.title = title
            self.description = description
        }
        
        static func ==(lhs: SectionHeader, rhs: SectionHeader) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    class Product: Equatable, Hashable {
        let id: UUID
        let name: String
        let description: String
        let image: URL?
        let price: Decimal
        var quantity: UInt
        
        let formattedPrice: String
        
        init(id: UUID, name: String, description: String, image: URL?, price: Decimal, quantity: UInt) {
            self.id = id
            self.name = name
            self.description = description
            self.image = image
            self.price = price
            self.quantity = quantity
            
            self.formattedPrice = "€\(price)"
        }
        
        static func ==(lhs: Product, rhs: Product) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    let id: UUID
    let type: `Type`
    let product: Product?
    let sectionHeader: SectionHeader?
    
    init(id: UUID, type: Type, product: Product? = nil, sectionHeader: SectionHeader? = nil) {
        self.id = id
        self.type = type
        self.product = product
        self.sectionHeader = sectionHeader
    }
    
    static func ==(lhs: AFTMenuCollectionData, rhs: AFTMenuCollectionData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
