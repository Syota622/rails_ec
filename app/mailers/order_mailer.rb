# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def order_confirmation(order)
    @order = order
    @discount_amount = @order.discount_amount || 0
    total_price = @order.order_items.sum { |item| item.price * item.quantity }
    @final_total_price = total_price - @discount_amount
    mail(to: @order.address.email_name, subject: 'Order Confirmation')
  end
end
