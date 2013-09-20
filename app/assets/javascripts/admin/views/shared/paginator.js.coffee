Augury.Views.Shared.Paginator = Backbone.View.extend(
  template: _.template "<span class='prev'>Previous</span><span class='next'>Next</span>"

  el: '#paginator'

  events:
    'click .prev': 'previous'
    'click .next': 'next'

  render: ->
    @$el.html @template()
    @

  previous: ->
    @trigger 'previous'

  next: ->
    @trigger 'next'
)
