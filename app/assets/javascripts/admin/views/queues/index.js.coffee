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

    if $('#input-date-range').val() != ''
      start_date   = $('#input-date-range').data('daterangepicker').startDate.utc().format()
      end_date     = $('#input-date-range').data('daterangepicker').endDate.utc().format()

    query =
      state: filter_state
      start_date: start_date
      end_date: end_date

    @queues.fetch(data: query, reset: true)
)

