Augury.vent.on 'connection:select', (signup, storeId, storeName) ->
  window.location.href = "/admin/integration/register?url=#{Augury.url}&env=#{signup.env}&user=#{signup.user}&user_token=#{signup.auth_token}&store_id=#{storeId}&store_name=#{storeName}"

Augury.vent.on 'connection:change', (connectionId) ->
  Backbone.history.navigate "/connections/#{connectionId}/connect", trigger: true
