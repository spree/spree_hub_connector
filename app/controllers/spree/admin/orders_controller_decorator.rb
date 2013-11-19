Spree::Admin::OrdersController.class_eval do
  before_action :set_up_hub, only: :edit

  private

  def set_up_hub
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
