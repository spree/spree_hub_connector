require 'spec_helper'

module Spree
  describe Api::IntegratorController do
    render_views

    before do
      stub_authentication!
    end

    it 'gets everything changed since' do
      order1 = create(:order,
             :updated_at => 1.days.ago,
             :completed_at => 1.days.ago)

      order2 = create(:order,
             :updated_at => 2.days.ago,
             :completed_at => 2.days.ago)

      api_get :index, since: 3.days.ago.utc.to_s,
               order_page: 1,
               order_per_page: 1

      json_response['orders']['count'].should eq 2
      json_response['orders']['current_page'].should eq 1

      o = json_response['orders']['page'].first
      o['number'].should eq order2.number
      o.should have_key('ship_address')
      o.should have_key('bill_address')
      o.should have_key('payments')
      o.should have_key('credit_cards')
    end
  end
end
