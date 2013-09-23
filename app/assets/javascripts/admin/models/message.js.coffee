Augury.Models.Message = Backbone.MongoModel.extend(
  initialize: ->
    @urlRoot = "/stores/#{Augury.store_id}/messages"

  has_errors: ->
    @get('last_error')

  integrationIconUrl: ->
    @get('integration_icon_url') if @get('is_consumer_remote')? && @get('integration_icon_url')?

  state: ->
    if @get('queue_name') == 'incoming'
      if @get('locked_at')?
        'running'
      else
        'pending'
    else
      @get('state')
)

