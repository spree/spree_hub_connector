Deface::Override.new(:virtual_path => "spree/admin/orders/edit",
                     :name => "add_notifications_to_orders",
                     :insert_bottom => "[data-hook='admin_order_edit_form']",
                     :text => %q{
                        <div id="embed_notifications" class="row">
                          <!-- Backbone app renders here -->
                        </div>

                        <%= javascript_tag do -%>
                          Augury = { SignUp: {}, Preload: {}, connections: {} };
                          Augury.SignUp.urls = {};
                          Augury.SignUp.urls['production'] = "https://hub.spreecommerce.com";
                          Augury.SignUp.urls['staging'] = "http://staging.hub.spreecommerce.com";
                          Augury.SignUp.name = '<%= Spree::Config[:site_name] %>';
                          Augury.SignUp.url = '<%= "http://#{request.host_with_port}/api/" %>';
                          Augury.SignUp.version = '<%= Spree.version.split('.')[0..1].join('.') rescue '' %>';
                          Augury.SignUp.api_key = '<%= @integrator_user.spree_api_key %>';
                          Augury.SignUp.user = '<%= spree_current_user.email %>';

                          <% AuguryEnvironment.all.each do |env| %>
                            Augury.connections[<%= env.id %>] = { url: '<%= env.url %>', token: '<%= env.token %>', environment: '<%= env.environment %>', user: '<%= env.user %>', store_name: '<%= env.store_name %>' };
                          <% end %>

                          Augury.env = '<%= @environment.environment %>';
                          Augury.url = '<%= @environment.url %>';
                          Augury.store_id = '<%= @environment.store_id %>';
                          Augury.api_key = '<%= @environment.token %>';
                          Augury.env_id = '<%= @environment.id %>';

                          $(function() {
                            return Augury.notifications('<%= @order.number %>');
                          });
                        <% end %>

                        <% if Rails.application.assets.find_asset('hub_client/notifications_manifest.js').nil? %>
                          <%= javascript_include_tag '//staging.hub.spreecommerce.com/notifications.min.js' %>
                        <% else %>
                          <%= javascript_include_tag 'hub_client/notifications_manifest.js' %>
                        <% end %>
                     },
                     :disabled => false)
