module Spree
  module Api
    module ApiHelpers

      def inventory_unit_attributes
        [:id, :lock_version, :state, :variant_id, :order_id,
          :shipment_id, :return_authorization_id, :serial_number]
      end

      def order_attributes_with_spree_hub_decoration
        order_attributes_without_spree_hub_decoration | [:currency, :tax_total, :visit_id, :visitor_id, :pageview_id, :last_pageview_id]
      end
      alias_method_chain :order_attributes, :spree_hub_decoration

    end
  end
end
