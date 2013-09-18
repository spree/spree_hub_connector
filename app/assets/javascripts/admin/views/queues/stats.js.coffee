Augury.Views.Queues.Stats = Backbone.View.extend(
  template: JST['admin/templates/queues/stats']

  initialize: ->
    @queue_stats = new Augury.Models.QueueStats
    @queue_stats.on 'change', @render, @
    @queue_stats.fetch()

  render: ->
    @$el.html @template(model: @queue_stats)
    @
)

