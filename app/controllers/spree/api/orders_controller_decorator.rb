Spree::Api::OrdersController.class_eval do
  helper_method :variant_attributes, :order_attributes

  private

  def variant_attributes
    [:id, :name, :product_id, :external_ref, :sku, :price, :weight, :height, :width, :depth, :is_master, :cost_price, :permalink]
  end

  # NOTE we should get rid of this duplication on later versions
  def order_attributes
    [:id, :number, :item_total, :total, :ship_total, :state, :adjustment_total, :user_id, :created_at, :updated_at, :completed_at, :payment_total, :shipment_state, :payment_state, :email, :special_instructions, :token, :total_weight, :locked_at, :channel]
  end
end
