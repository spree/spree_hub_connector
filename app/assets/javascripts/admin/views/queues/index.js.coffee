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
    # Set queue stats
    stats_view = new Augury.Views.Queues.Stats(model: Augury.queue_stats, queue_name: @collection.queue_name)
    @$el.find('#messages-queue').before stats_view.render().el

    if @collection.queue_name == 'incoming'
      @$el.find('#messages-filters').prepend @templateIncomingFilters()
    else
      @$el.find('#messages-filters').prepend @templateMessageFilters(collection: @collection)

    @renderTable()

    if @options.state?
      @$el.find('#status-select').val @options.state
    @

  renderTable: ->
    @$el.find('#messages-view').html @collectionTemplateTable()(collection: @collection)
    # Set up pagination
    paginator = new Augury.Views.Shared.Paginator(collection: @collection)
    @$el.find('#messages-view').append paginator.render().el


  collectionTemplateTable: ->
    switch @collection.queue_name
      when 'incoming' then @templateIncomingTable
      when 'accepted' then @templateAcceptedTable
      when 'archived' then @templateArchivedTable

  search: (e) ->
    e.preventDefault()
    @setQueryFields()
    @collection.fetch(data: @collection.queryFields(), reset: true)

  setQueryFields: ->
    @collection.clearQueryFields()

    if @collection.queue_name != 'incoming'
      @collection.setQueryField 'filter_state'   , @$el.find('#status-select').select2('val')
      @collection.setQueryField 'message'        , @$el.find('#message-select').select2('val')
      @collection.setQueryField 'consumer_class' , @$el.find('#consumer-select').select2('val')

    if $('#input-date-range').val() != ''
      @collection.setQueryField 'start_date' , $('#input-date-range').data('daterangepicker').startDate.utc().format()
      @collection.setQueryField 'end_date'   , $('#input-date-range').data('daterangepicker').endDate.utc().format()
)

