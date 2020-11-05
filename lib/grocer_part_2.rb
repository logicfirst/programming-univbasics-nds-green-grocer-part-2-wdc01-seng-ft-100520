require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  cart.each do |item|
    coupons.each do |coupon|
      if item[:item] == coupon[:item] && item[:count] - coupon[:num] >= 0
        item_with_coupon = {
          item: "#{item[:item]} W/COUPON",
          price: coupon[:cost] / coupon[:num],
          clearance: item[:clearance],
          count: coupon[:num]
        }
        cart << item_with_coupon
        item[:count] = item[:count] - coupon[:num]
      end
    end
  end
  cart  
end

def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance] == true
      item[:price] = (item[:price] - (item[:price] * 0.20)).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0.0
  final_cart.each do |item|
    total = (total + (item[:price] * item[:count])).round(2)
  end
  if total > 100.00
    total = (total - (total * 0.10)).round(2)
  end
  total
end
