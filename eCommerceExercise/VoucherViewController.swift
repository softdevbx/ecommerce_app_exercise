//
//  VoucherViewController.swift
//  eCommerceExercise
//
//  Created by Sara OC on 17/06/2015.
//  Copyright (c) 2015 Sara OC Inc. All rights reserved.
//

import UIKit

class VoucherViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // voucher collection view set up
    
    var data = VoucherList()

    @IBOutlet weak var voucherCollection: UICollectionView!

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.voucherDisplayCategory.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let voucherCell = collectionView.dequeueReusableCellWithReuseIdentifier("voucherCell", forIndexPath: indexPath) as! VoucherCollectionViewCell
        
        voucherCell.voucherCategory.text = data.voucherDisplayCategory[indexPath.row]
        voucherCell.voucherConditions.text = data.voucherConditionDescription[indexPath.row]
        voucherCell.voucherImage.image = UIImage(named: data.voucherImage[indexPath.row])
        
        voucherCell.addToCartButton.tag = indexPath.row
        voucherCell.addToCartButton.addTarget(self, action: "addToCart:", forControlEvents: .TouchUpInside)
        
        voucherCell.removeFromCartButton.hidden = true
        voucherCell.removeFromCartButton.tag = indexPath.row
        voucherCell.removeFromCartButton.addTarget(self, action: "removeFromCart:", forControlEvents: .TouchUpInside)
        
        if contains(cart.cartVouchers, indexPath.row) {
            voucherCell.removeFromCartButton.hidden = false
            voucherCell.addToCartButton.hidden = true
        } else {
            voucherCell.removeFromCartButton.hidden = true
            voucherCell.addToCartButton.hidden = false
        }
        
        return voucherCell
    }
    
    // add and remove vouchers
    var cart = CartBrain()
    @IBOutlet weak var voucherErrorMessage: UILabel!
    
    func addToCart(sender: UIButton) {
        let selectedVoucher = sender.tag
        voucherErrorMessage.text = ""
        self.checkVoucher(selectedVoucher)
        updateCartDisplay()
        voucherCollection.reloadData()
    }
    
    func removeFromCart(sender: UIButton) {
        let selectedVoucher = sender.tag
        cart.removeObject(selectedVoucher, fromArray: &cart.cartVouchers)
        updateCartDisplay()
        voucherCollection.reloadData()
    }
    
    // check voucher
    func checkVoucher(selectedVoucher: Int) {
        if cart.checkVoucher(selectedVoucher) {
            cart.cartVouchers.append(selectedVoucher)
        } else {
            voucherErrorMessage.text = "Your order doesn't qualify for this voucher."
        }
    }
    
    // shopping bag "cart" display
    @IBOutlet weak var cartItemCount: UIButton!
    @IBOutlet weak var cartTotal: UILabel!

    func updateCartDisplay() {
        cartItemCount.setTitle("\(cart.cartProducts.count)", forState: UIControlState.Normal)
        cart.totalCart()
        cartTotal.text = "£" + String.localizedStringWithFormat("%.2f", cart.total)
    }
    
    // passing cart data between views
    var passedTotal:String!
    var passedCartContents:[Int]!
    var passedVouchers:[Int]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if passedTotal != nil {
            cartTotal.text = passedTotal
            cart.cartProducts = passedCartContents
            cartItemCount.setTitle("\(cart.cartProducts.count)", forState: UIControlState.Normal)
        }
        
        if passedVouchers != nil {
            cart.cartVouchers = passedVouchers
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueFromVouchers") {
            var svc = segue.destinationViewController as! ProductViewController;
            
            svc.passedTotalFromVouchers = cartTotal.text
            svc.passedCartContentsFromVouchers = cart.cartProducts
            svc.passedCartVouchersFromVouchers = cart.cartVouchers
            
        }
    }

}
