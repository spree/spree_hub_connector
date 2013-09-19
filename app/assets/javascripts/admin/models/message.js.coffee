Augury.Models.Message = Backbone.MongoModel.extend(
  initialize: ->
    @urlRoot = "/stores/#{Augury.store_id}/messages"

  has_errors: ->
    @get('last_error')

  consumer_image_name: ->
    if @get('is_consumer_remote')
      @get('destination_name')
    else
      'spree'
)

