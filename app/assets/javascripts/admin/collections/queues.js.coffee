Augury.Collections.Queues = Augury.PaginatedCollection.extend(
  model: Augury.Models.Message

  initialize: (models, options) ->
    @queue_name = options.queue_name
    @url = "/stores/#{Augury.store_id}/queues/#{@queue_name}"

  parse: (data) ->
    @page                = data.page
    @pages               = data.pages
    @available_messages  = data.available_messages
    @available_consumers = data.available_consumers
    data.messages
)
