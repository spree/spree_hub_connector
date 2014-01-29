Spree::Admin::BaseController.class_eval do
  before_action :setup_hub

  private

  def setup_hub
    email = 'integrator@spreecommerce.com'
    if @integrator_user = Spree.user_class.where('email' => email).first
      # do nothing, for now....
    else
      passwd = SecureRandom.hex(32)

      integration_user_attrs = { 'email'                 => email,
                                 'password'              => passwd,
                                 'password_confirmation' => passwd }.merge(integration_user_extra_attrs)

      @integrator_user = Spree.user_class.create(integration_user_attrs)

      @integrator_user.spree_roles << Spree::Role.all
      @integrator_user.generate_spree_api_key!
    end

    @environment = AuguryEnvironment.where(id: Spree::Config.augury_current_env).first
  end
end
