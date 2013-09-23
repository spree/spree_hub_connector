Augury.Collections.Queues = Backbone.Collection.extend(
  model: Augury.Models.Message

  initialize: (models, options) ->
    @queue_name = options.queue_name
    @url = "/stores/#{Augury.store_id}/queues/#{@queue_name}"

  parse: (data) ->
    @page                = data.page
    @pages               = data.pages
    @available_messages  = data.available_messages
    @available_consumers = data.available_consumers
    data.messages


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

