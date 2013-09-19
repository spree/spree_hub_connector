Augury.Models.Message = Backbone.MongoModel.extend(
  initialize: ->
    @urlRoot = "/stores/#{Augury.store_id}/messages"

  has_errors: ->
    @get('last_error')
)

