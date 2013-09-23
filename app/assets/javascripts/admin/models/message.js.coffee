Augury.Models.Message = Backbone.MongoModel.extend(
  initialize: ->
    @urlRoot = "/stores/#{Augury.store_id}/messages"

  has_errors: ->
    @get('last_error')

  integration_icon_url: ->
    @get('integration_icon_url') if @get('is_consumer_remote')? && @get('integration_icon_url')?
)

