require 'spec_helper'

module Spree
  describe Admin::IntegrationController  do
    render_views
    context "authenticated" do

      before do
        controller.stub :try_spree_current_user => double('User', has_spree_role?: true)
      end

      describe '#show' do
        it 'creates an integration user'
        it 'creates an integration user whith given extra atts'
      end
    end
  end
end
