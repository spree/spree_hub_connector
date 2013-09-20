Augury.Views.Shared.Paginator = Backbone.View.extend(
  initialize: (options) ->
    @_collection = options.collection

  id: 'paginator'
  tagName: 'div'

  template: _.template "<span class='prev'><a href='#'>Previous</a></span>&nbsp;<span class='next'><a href='#'>Next</a></span>"

  events:
    'click .prev': 'previous'
    'click .next': 'next'

  render: ->
    @$el.html @template()
    @

  previous: ->
    @_collection.prevPage()

  next: ->
    @_collection.nextPage()
)
