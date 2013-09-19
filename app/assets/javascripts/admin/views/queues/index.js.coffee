Augury.Views.Queues.Index = Backbone.View.extend(
  el: '#integration_main'

  template: JST['admin/templates/queues/index']

  events:
    'click button[type=submit]': 'search'

  initialize: (@options) ->
    @queues = new Augury.Collections.Queues([], queue_name: @options.queue_name)
    @queues.on 'reset', @update_messages_view, @
    @stats_view = new Augury.Views.Queues.Stats
    @queues.fetch(reset: true)

  render: ->
    @

  update_messages_view: (collection) ->
    @$el.html @template(collection: collection, queue_name: @options.queue_name)
    @$el.find('#messages-queue').before @stats_view.render().el

  search: ->
    filter_state = @$el.find('#status-select').select2('data').text.toLowerCase()
    query =
      state: filter_state

    @queues.fetch(data: query, reset: true)
)

