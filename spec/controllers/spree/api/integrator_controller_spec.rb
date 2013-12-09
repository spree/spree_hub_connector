require 'spec_helper'

module Spree
  describe Api::IntegratorController do
    render_views

    context "authenticated" do
      before { stub_authentication! }

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
