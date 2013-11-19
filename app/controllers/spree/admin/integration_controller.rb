module Spree
  module Admin
    class IntegrationController < Spree::Admin::BaseController
      def register
        env = AuguryEnvironment.create(store_id: params[:store_id],
                                       url: params[:url],
                                       user: params[:user],
                                       token: params[:user_token],
                                       store_name: params[:store_name],
                                       environment: params[:env])
        Spree::Config.augury_current_env = env.id

        redirect_to :action => :show
      end

      def connect
        Spree::Config.augury_current_env = params[:env_id]
        redirect_to :action => :show
      end

      def disconnect
        Spree::Config.augury_current_env = nil
        redirect_to :action => :show
      end

      def show
      end
    end
  end
end
