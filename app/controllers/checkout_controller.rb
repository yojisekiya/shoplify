class CheckoutController < ApplicationController
  def create
    product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create(
      {
        customer: current_user.stripe_customer_id,
        line_items: [
          {
            price: product.stripe_price_id,
            quantity: 1
          }
        ],
        mode: 'payment',
        success_url: root_url + "?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: root_url
      }
    )
    respond_to do |format|
      format.js
    end
  end
end
