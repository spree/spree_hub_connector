Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "setup_hub",
                     :insert_bottom => "head",
                     :text => %q{
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

                          <% if @environment %>
                            Augury.env = '<%= @environment.environment %>';
                            Augury.url = '<%= @environment.url %>';
                            Augury.store_id = '<%= @environment.store_id %>';
                            Augury.api_key = '<%= @environment.token %>';
                            Augury.env_id = '<%= @environment.id %>';
                          <% end %>

                        <% end %>
                     },
                     :disabled => false)
