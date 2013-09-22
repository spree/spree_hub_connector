Augury.Views.Shared.Paginator = Backbone.View.extend(
  initialize: (options) ->
    @_collection = options.collection

  id: 'paginator'
  tagName: 'div'

  template: JST['admin/templates/shared/pagination']

  events:
    'click .prev': 'previous'
    'click .next': 'next'

  render: ->
    @$el.html @template()
    @

  previous: (e) ->
    e.preventDefault()
    @_collection.prevPage()

  next: (e) ->
    e.preventDefault()
    @_collection.nextPage()
)

