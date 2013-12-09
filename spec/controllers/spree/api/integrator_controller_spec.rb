require 'spec_helper'

module Spree
  describe Api::IntegratorController do
    render_views

    context "authenticated" do
      before do
        controller.stub :current_api_user => double("User")
        controller.current_api_user.stub has_spree_role?: true
      end

      it 'gets orders changed since' do
        order = create(:completed_order_with_totals)
        Order.update_all(:updated_at => 2.days.ago)

        api_get :index, since: 3.days.ago, order_page: 1, order_per_page: 1

        json_response['orders']['count'].should eq 1
        json_response['orders']['current_page'].should eq 1

        json_response['orders']['page'].first['number'].should eq order.number
        json_response['orders']['page'].first.should have_key('ship_address')
        json_response['orders']['page'].first.should have_key('bill_address')
        json_response['orders']['page'].first.should have_key('payments')
        json_response['orders']['page'].first.should have_key('credit_cards')
      end

      it 'gets stock_transfers changed since' do
        source = create(:stock_location)
        destination = create(:stock_location_with_items, :name => 'DEST101')
        stock_transfer = StockTransfer.create do |transfer|
          transfer.source_location_id = source.id
          transfer.destination_location_id = destination.id
          transfer.reference = 'PO 666'
        end
        StockTransfer.update_all(:updated_at => 2.days.ago)

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

        api_get :index, since: 3.days.ago.utc.to_s,
                        stock_transfers_page: 1,
                        stock_transfers_per_page: 1

        transfer = json_response['stock_transfers']['page'].first
        transfer['destination_location']['name'].should eq 'DEST101'
        transfer['destination_movements'].first['quantity'].should eq 1
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

    it 'adds custom variant attributes' do
      attr = controller.send(:variant_attributes)
      attr.should include(:external_ref)
      attr.should include(:product_id)
    end
  end
end
