require 'spec_helper'
require 'pry-byebug'

module Spree
  describe Api::IntegratorController do
    render_views

    before { stub_authentication! }

    describe '#index' do
      it 'gets all available collections' do
        api_get :index, message: 'hub:poll'

        expect(json_response['collections']).to have(5).items
      end

      context 'when request show_* listed on index' do
        it 'all collections should be available to show' do
          api_get :index, message: 'hub:poll'

          json_response['collections'].each do |collection|
            api_get "show_#{collection['name']}", since: 3.days.ago.utc.to_s,
              page: 1,
              per_page: 1

            response.should be_ok
          end
        end
      end

      context 'when old poller i.e. spree:order:poll' do
        it 'gets all available collections' do
          api_get :index

          expect(json_response).to have_key('orders')
          expect(json_response).to have_key('stock_transfers')
        end
      end
    end

    describe '#show_orders' do
      it 'gets orders changed since' do
        order = create(:completed_order_with_totals)
        Order.update_all(updated_at: 2.days.ago)

        api_get :show_orders, since: 3.days.ago.utc.to_s,
          page: 1,
          per_page: 1

        json_response['count'].should eq 1
        json_response['current_page'].should eq 1

        json_response['orders'].first['number'].should eq order.number
        json_response['orders'].first.should have_key('ship_address')
        json_response['orders'].first.should have_key('bill_address')
        json_response['orders'].first.should have_key('payments')
        json_response['orders'].first.should have_key('credit_cards')
      end
    end

    describe '#show_products' do
      it 'gets products changed since' do
        product = create(:product)
        Product.update_all(updated_at: 2.days.ago)

        api_get :show_products, since: 3.days.ago.utc.to_s,
          page: 1,
          per_page: 1

        json_response['count'].should eq 1
        json_response['current_page'].should eq 1
        json_response['products'].first['id'].should eq product.id
      end
    end

    describe '#show_users' do
      it 'gets users changed since' do
        user = create(:user)
        Spree.user_class.update_all(updated_at: 2.days.ago)

        api_get :show_users, since: 3.days.ago.utc.to_s,
          page: 1,
          per_page: 1

        json_response['count'].should eq 1
        json_response['current_page'].should eq 1
        json_response['users'].first['id'].should eq user.id
      end
    end

    describe '#show_return_authorizations' do
      it 'gets return_authorizations changed since' do
        return_authorization = create(:return_authorization)
        ReturnAuthorization.update_all(updated_at: 2.days.ago)

        api_get :show_return_authorizations, since: 3.days.ago.utc.to_s,
          page: 1,
          per_page: 1

        json_response['count'].should eq 1
        json_response['current_page'].should eq 1
        json_response['return_authorizations'].first['id'].should eq return_authorization.id
      end
    end
  end
end

