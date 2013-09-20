Augury.Views.Queues.Stats = Backbone.View.extend(
  template: JST['admin/templates/queues/stats']

  initialize: (@options={}) ->
    @queue_stats = new Augury.Models.QueueStats
    @queue_stats.on 'change', @render, @
    @queue_stats.fetch()

  render: ->
    @$el.html @template(model: @queue_stats, queue_name: @options.queue_name)
    @
)

