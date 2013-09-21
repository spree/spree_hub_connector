Augury.Views.Queues.Stats = Backbone.View.extend(
  template: JST['admin/templates/queues/stats']

  initialize: (@options={}) ->

  render: ->
    @$el.html @template(model: Augury.queue_stats, queue_name: @options.queue_name)
    @
)

