Augury.Views.Queues.Stats = Backbone.View.extend(
  initialize: ->
    @queue_stats = new Augury.Models.QueueStats
    @queue_stats.on 'change', @render, @
    @queue_stats.fetch()

  render: ->
    @$el.html JST['admin/templates/queues/stats'](model: @queue_stats)
    @
)

