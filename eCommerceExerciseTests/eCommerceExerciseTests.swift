//
//  eCommerceExerciseTests.swift
//  eCommerceExerciseTests
//
//  Created by Sara OC on 13/06/2015.
//  Copyright (c) 2015 Sara OC Inc. All rights reserved.
//

import UIKit
import XCTest

class eCommerceExerciseTests: XCTestCase {
    
    let brain = CartBrain()
    let productVC = ProductViewController()
    let productView = CollectionViewCell()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func canAddItemToCart() {
        
//        let addToCart = productVC.addToCart(productView.addToCartButton.tag)
//        let itemsInCart = brain.cartProducts.count
//        XCTAssertEqual(addToCart, itemsInCart == 1, "Can add item to cart")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
