Augury.Models.QueueStats = Backbone.Model.extend(
  initialize: ->
    @urlRoot = "/stores/#{Augury.store_id}/queues"

    @on 'change', @update_round_and_sign_attributes

  update_round_and_sign_attributes: ->
    _.each ['incoming', 'archived', 'pending', 'parked', 'scheduled', 'failing'], (attr) =>
      @set "#{attr}_round" , @metric_round @get(attr)
      @set "#{attr}_sign"  , @metric_sign  @get(attr)


  metric_round: (y) ->
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

  metric_sign: (y) ->
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

