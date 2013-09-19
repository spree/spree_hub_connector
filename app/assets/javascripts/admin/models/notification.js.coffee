Augury.Models.Notification = Backbone.Model.extend(
  initialize: ->
    @urlRoot = "/stores/#{Augury.store_id}/notifications"

  toJSON: ->
    @attributes = _.omit(@attributes, ['id'])
    return notification: _(@attributes).clone()
)
