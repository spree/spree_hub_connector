Augury.Views.Queues.Index = Backbone.View.extend(
  el: '#integration_main'

  template: JST['admin/templates/queues/index']

  events:
    'click button[type=submit]': 'search'

  initialize: ->
    @stats_view = new Augury.Views.Queues.Stats(queue_name: @model.get('id'))
    @model.on 'change', @render, @

  render: ->
    @$el.html @template(model: @model)
    @$el.find('#messages-queue').before @stats_view.render().el
    @

  search: ->
    filter_state = @$el.find('#status-select').select2('data').text.toLowerCase()
    message      = @$el.find('#message-select').select2('data').text.toLowerCase()

    if $('#input-date-range').val() != ''
      start_date = $('#input-date-range').data('daterangepicker').startDate.utc().format()
      end_date   = $('#input-date-range').data('daterangepicker').endDate.utc().format()


    query =
      state: filter_state
      start_date: start_date
      end_date: end_date
      message: message

    @model.fetch(data: query)
)

