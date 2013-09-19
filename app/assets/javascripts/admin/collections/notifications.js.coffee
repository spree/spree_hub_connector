Augury.Collections.Notifications = Backbone.Collection.extend(
  model: Augury.Models.Notification

  initialize: ->
    @url = "/stores/#{Augury.store_id}/notifications"
)
