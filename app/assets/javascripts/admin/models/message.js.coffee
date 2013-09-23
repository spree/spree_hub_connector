Augury.Models.Message = Backbone.MongoModel.extend(
  initialize: ->
    @urlRoot = "/stores/#{Augury.store_id}/messages"

  has_errors: ->
    @get('last_error')

  integration_icon_url: ->
    switch
      when @get('is_consumer_remote')   then '/assets/integrations/spree.png' # For local consumers
      when @get('integration_icon_url') then @get('integration_icon_url')     # For remote consumers *with* icon_url defined
      else '/assets/integrations/spree.png'                                   # For remote consumers *without* icon_url defined
)

