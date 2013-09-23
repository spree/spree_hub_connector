Augury.Views.Queues.Index = Backbone.View.extend(
  template:                JST['admin/templates/queues/index']
  templateIncomingTable:   JST['admin/templates/queues/incoming_table']
  templateAcceptedTable:   JST['admin/templates/queues/accepted_table']
  templateArchivedTable:   JST['admin/templates/queues/archived_table']
  templateMessageFilters:  JST['admin/templates/queues/message_filters']
  templateIncomingFilters: JST['admin/templates/queues/incoming_filters']

  events:
    'click button[type=submit]': 'search'

  initialize: ->
    @collection.on 'reset', @renderTable, @

  render: ->
    @$el.html @template(collection: @collection)
    if @options.state
      @$el.find('#status-select').select2('val', @options.state)
    # Set queue stats
    stats_view = new Augury.Views.Queues.Stats(queue_name: @collection.queue_name)
    @$el.find('#messages-queue').before stats_view.render().el

    if @collection.queue_name == 'incoming'
      @$el.find('#messages-filters').prepend @templateIncomingFilters()
    else
      @$el.find('#messages-filters').prepend @templateMessageFilters(collection: @collection)

    @renderTable()
    @

  renderTable: ->
    @$el.find('#messages-view').html @collectionTemplateTable()(collection: @collection)
    # Set up pagination
    paginator = new Augury.Views.Shared.Paginator(collection: @)
    @$el.find('#messages-view').append paginator.render().el


  collectionTemplateTable: ->
    switch @collection.queue_name
      when 'incoming' then @templateIncomingTable
      when 'accepted' then @templateAcceptedTable
      when 'archived' then @templateArchivedTable

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
    if @collection.queue_name != 'incoming'
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

