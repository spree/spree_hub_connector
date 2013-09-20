Augury.PaginatedCollection = Backbone.Collection.extend(
  initialize: (options) ->
    @_page = 1

  nextPage: ->
    @changePage(1)

  prevPage: ->
    @changePage(-1)

  changePage: (delta) ->
    @setPage(@_page + delta)

  setPage: (page) ->
    @_page = page
    @fetch(reset: true)
)
