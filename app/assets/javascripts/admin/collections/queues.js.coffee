Augury.Collections.Queues = Backbone.Collection.extend(
  model: Augury.Models.Message

  initialize: (models, options) ->
    @url = "/stores/#{Augury.store_id}/queues/#{options.queue_name}"
)

