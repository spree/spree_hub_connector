Augury.Collections.Notifications = Backbone.Collection.extend(
  model: Augury.Models.Notification

  url: ->
    if @_query
      "/stores/#{Augury.store_id}/notifications?#{@_query}"
    else
      "/stores/#{Augury.store_id}/notifications"

  query: (q) ->
    @_query = @serializeToQueryString(q, 'q')
    @fetch(reset: true)

  all: ->
    @_query = false
    @fetch(reset: true)
)
