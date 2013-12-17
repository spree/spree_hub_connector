module Spree
  Variant.class_eval do
    def product_updated_at
      product.updated_at
    end

    def product_created_at
      product.created_at
    end
  end
end
