require 'spec_helper'
require 'pry-byebug'

module Spree
  describe Api::IntegratorController do
    render_views

    context "authenticated" do
      before do
        controller.stub :current_api_user => double("User")
        controller.current_api_user.stub has_spree_role?: true
      end

      describe '#index' do
        it 'gets all available collections' do
          api_get :index, message: 'hub:poll'

          expect(json_response['collections']).to have(7).items
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

      describe '#show_stock_transfers' do
        it 'gets stock_transfers changed since' do
          source = create(:stock_location)
          destination = create(:stock_location_with_items, name: 'DEST101')
          stock_transfer = StockTransfer.create do |transfer|
            transfer.source_location_id = source.id
            transfer.destination_location_id = destination.id
            transfer.reference = 'PO 666'
          end
          StockTransfer.update_all(updated_at: 2.days.ago)

          StockMovement.create do |movement|
            movement.stock_item = source.stock_items.first
            movement.quantity = -1
            movement.originator = stock_transfer
          end

          StockMovement.create do |movement|
            movement.stock_item = destination.stock_items.first
            movement.quantity = 1
            movement.originator = stock_transfer
          end

          api_get :show_stock_transfers, since: 3.days.ago.utc.to_s,
            page: 1,
            per_page: 1

          transfer = json_response['stock_transfers'].first
          transfer['destination_location']['name'].should eq 'DEST101'
          transfer['destination_movements'].first['quantity'].should eq 1
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

      describe '#show_taxons' do
        it 'gets taxons changed since' do
          taxon = Taxon.create!(name: "Foobar")
          Taxon.update_all(updated_at: 2.days.ago)

          api_get :show_taxons, since: 3.days.ago.utc.to_s,
            page: 1,
            per_page: 1

          json_response['count'].should eq 1
          json_response['current_page'].should eq 1
          json_response['taxons'].first['id'].should eq taxon.id
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
          json_response['return_authorizations'].first['order']['id'].should eq return_authorization.order.id
        end
      end
    end

    context "unauthenticated" do
      it "can't access orders list" do
        api_get :index
        expect(response.status).to eq 401
      end

      context "provides token" do
        let(:user) { create(:user) }

        before do
          LegacyUser.stub(find_by_spree_api_key: user)
        end

        it "can access orders list if admin" do
          user.stub(:has_spree_role?).with("admin").and_return(true)
          api_get :index, token: "123"
          expect(response).to be_ok
        end

        it "can't access orders list if not admin" do
          user.stub(:has_spree_role?).with("admin").and_return(false)
          api_get :index, token: "123"
          expect(response.status).to eq 401
        end
      end
    end

    context "non admin user" do
      let(:user) { create(:user) }

      before { controller.stub try_spree_current_user: user }

      it "cant access orders list" do
        expect(user).not_to have_spree_role "admin"

        api_get :index
        expect(response.status).to eq 401
      end
    end
  end
end
