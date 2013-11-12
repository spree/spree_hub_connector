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
        email = 'integrator@spreecommerce.com'
        if @integrator_user = Spree.user_class.where('email' => email).first
          # do nothing, for now....
        else
          passwd = SecureRandom.hex(32)
          @integrator_user = Spree.user_class.create('email' => email,
                                    'password' => passwd,
                                    'password_confirmation' => passwd)

          @integrator_user.spree_roles << Spree::Role.all
          @integrator_user.generate_spree_api_key!
        end

        @environment = AuguryEnvironment.last
      end
    end
  end
end
