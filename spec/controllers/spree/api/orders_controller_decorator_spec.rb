require 'spec_helper'

module Spree
  describe Api::OrdersController do
    render_views

    context "authenticated" do
      before do
        controller.stub :try_spree_current_user => double("User", has_spree_role?: true)
      end

      describe '#show' do
        it 'includes spree_jirafe attributes' do
          order = create(:order)
          # TODO: add spree_jirafe to the Gemfile and remove this stubbing?
          Order.any_instance.stub(visit_id: 1, visitor_id: 1, pageview_id: 1, last_pageview_id: 1)

          api_get :show, id: order.to_param

          json_response.should have_key('visit_id')
          json_response.should have_key('visitor_id')
          json_response.should have_key('pageview_id')
          json_response.should have_key('last_pageview_id')
        end
      end
    end
  end
end
