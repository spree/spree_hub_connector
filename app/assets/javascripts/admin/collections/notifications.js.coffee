Augury.Collections.Notifications = Backbone.Collection.extend(
  model: Augury.Models.Notification

  url: ->
    "/stores/#{Augury.store_id}/notifications"
)
