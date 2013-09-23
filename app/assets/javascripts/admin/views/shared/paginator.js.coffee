Augury.Views.Shared.Paginator = Backbone.View.extend(
  initialize: (options) ->
    @_collection = options.collection
    window.ccc = @_collection

  id: 'paginator'
  tagName: 'div'

  template: JST['admin/templates/shared/pagination']

  events:
    'click .prev':   'previous'
    'click .next':   'next'
    'click .first':  'first'
    'click .last':   'last'

  render: ->
    @$el.html @template(collection: @_collection)
    @

  previous: (e) ->
    e.preventDefault()
    @_collection.prevPage()

  next: (e) ->
    e.preventDefault()
    @_collection.nextPage()

  first: (e) ->
    e.preventDefault()
    @_collection.firstPage()

  last: (e) ->
    e.preventDefault()
    @_collection.lastPage()
)

