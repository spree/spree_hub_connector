Deface::Override.new(:virtual_path => "spree/admin/orders/edit",
                     :name => "add_notifications_to_orders",
                     :insert_bottom => "[data-hook='admin_order_edit_form']",
                     :text => %q{
                        <div id="embed_notifications" class="row">
                          <!-- Backbone app renders here -->
                        </div>

                        <%= javascript_tag do -%>
                          $(function() {
                            return Augury.notifications('<%= @order.number %>');
                          });
                          $(document).ajaxComplete(function() {
                            $('.integration-image-wrapper').powerTip({
                              placement: 'e'
                            });
                          });                        
                        <% end %>

                        <% if Rails.application.assets.find_asset('hub_client/notifications_manifest.js').nil? %>
                          <%= javascript_include_tag '//staging.hub.spreecommerce.com/notifications.min.js' %>
                        <% else %>
                          <%= javascript_include_tag 'hub_client/notifications_manifest.js' %>
                        <% end %>
                     },
                     :disabled => false)
