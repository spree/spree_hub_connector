Augury.Models.QueueStats = Backbone.Model.extend(
  initialize: ->
    @urlRoot = "/stores/#{Augury.store_id}/queues"

  metric_round: (metric_name) ->
    y = @get(metric_name)
    if typeof y != 'number'
      y
    else if y >= 1000000000000
      Math.round(y/1000000000000)
    else if y >= 1000000000
      Math.round(y/1000000000)
    else if y >= 1000000
      Math.round(y/1000000)
    else if y >= 1000
      Math.round(y/1000)
    else if y < 1 && y > 0
      y.toFixed(1)
    else
      Math.round(y)

  metric_sign: (metric_name) ->
    y = @get(metric_name)
    return '' if typeof y != 'number' || y < 1000
    if y >= 1000000000000
      'T'
    else if y >= 1000000000
      'B'
    else if y >= 1000000
      'M'
    else if y >= 1000
      'K'
)

