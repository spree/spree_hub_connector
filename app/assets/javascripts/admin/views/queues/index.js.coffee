Augury.Views.Queues.Index = Backbone.View.extend(
  el: '#integration_main'

  template:       JST['admin/templates/queues/index']
  templateTable:  JST['admin/templates/queues/messages_table']

  events:
    'click button[type=submit]': 'search'

  initialize: ->
    @stats_view = new Augury.Views.Queues.Stats(queue_name: @collection.queue_name)
    @collection.on 'reset', @renderTable, @

  render: ->
    @$el.html @template(collection: @collection)
    @$el.find('#messages-queue').before @stats_view.render().el
    @renderTable()
    @

  renderTable: ->
    @$el.find('#messages-view').html @templateTable(collection: @collection)
    # Set up pagination
    @paginator = new Augury.Views.Shared.Paginator(collection: @)
    @$el.find('#messages-view').append @paginator.render().el

  prevPage: ->
    query = @queue_query()
    query.page = @collection.page - 1
    @collection.fetch(data: query, reset: true)

  nextPage: ->
    query = @queue_query()
    query.page = @collection.page + 1
    @collection.fetch(data: query, reset: true)

  search: (e) ->
    e.preventDefault()
    @collection.fetch(data: @queue_query(), reset: true)

  queue_query: ->
    filter_state   = @$el.find('#status-select').select2('val')
    message        = @$el.find('#message-select').select2('val')
    consumer_class = @$el.find('#consumer-select').select2('val')

    if $('#input-date-range').val() != ''
      start_date = $('#input-date-range').data('daterangepicker').startDate.utc().format()
      end_date   = $('#input-date-range').data('daterangepicker').endDate.utc().format()

    state: filter_state
    start_date: start_date
    end_date: end_date
    message: message
    consumer_class: consumer_class
)

