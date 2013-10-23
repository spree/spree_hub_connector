if defined?(Devise) && defined?(Spree::Auth)
  require 'httparty'

  module Spree
    UserMailer.class_eval do
      def reset_password_instructions(user)
        augury_environment = AuguryEnvironment.find(Spree::Config.augury_current_env)

        return unless augury_environment

        recipient = user.respond_to?(:id) ? user : Spree.user_class.find(user)
        password_reset_url = spree.edit_spree_user_password_url(:reset_password_token => recipient.reset_password_token, :host => Spree::Config.site_url)
        hub_message_push_url = "http://localhost:4000/api/stores/#{augury_environment.store_id}/messages"
        password_reset_message = {
          origin: 'store',
          message: 'user:password_reset',
          payload: {
            id: recipient.id,
            email: recipient.email,
            link: password_reset_url
          }
        }

        options = {
          headers: { 'Content-Type' => 'application/json', 'X-Augury-Token' => augury_environment.token },
          body: password_reset_message.to_json
        }

        response = HTTParty.post(hub_message_push_url, options)
      end
    end
  end
end
