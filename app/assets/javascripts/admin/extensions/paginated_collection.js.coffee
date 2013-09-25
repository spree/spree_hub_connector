Augury.PaginatedCollection = Backbone.Collection.extend(
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
