require 'spec_helper'

module Spree
  describe Api::OrdersController do
    render_views

    context "authenticated" do
      before do
        controller.stub :try_spree_current_user => double("User", has_spree_role?: true)
      end

      describe '#show_orders' do
        it 'gets orders changed since' do
          order = create(:order)

          api_get :show, id: order.to_param

          json_response.should have_key('currency')
        end
      end
    end
  end
end
