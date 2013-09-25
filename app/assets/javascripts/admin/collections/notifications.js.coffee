Augury.Collections.Notifications = Augury.PaginatedCollection.extend(
  model: Augury.Models.Notification

  url: ->
    "/stores/#{Augury.store_id}/notifications"

  setQueryField: (key, value) ->
    return unless value?
    @_query ||= {}
    @_query[key] = value

  clearQueryFields: ->
    @_query = {}

  queryFields: ->
    @_query
)
