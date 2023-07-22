# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def order_confirmation(order)
    @order = order
    mail(to: @order.address.email_name, subject: 'Order Confirmation')
  end
end
