Augury.Collections.Notifications = Backbone.Collection.extend(
  model: Augury.Models.Notification

  url: ->
    "/stores/#{Augury.store_id}/notifications"

  parse: (data) ->
    @page                = data.page
    @pages               = data.pages
    data.notifications

  setQueryField: (key, value) ->
    return unless value?
    @_query ||= {}
    @_query[key] = value

  clearQueryFields: ->
    @_query = {}

  queryFields: ->
    @_query

  prevPage: ->
    @_paginate(@page - 1)

  nextPage: ->
    @_paginate(@page + 1)

  firstPage: ->
    @_paginate(1)

  lastPage: ->
    @_paginate(@pages)

  _paginate: (page) ->
    @setQueryField('page',  page)
    @fetch(data: @_query, reset: true)
)
