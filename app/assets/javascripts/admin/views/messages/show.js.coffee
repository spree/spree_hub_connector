Augury.Views.Messages.Show = Backbone.View.extend(
  render: ->
    @$el.html JST["admin/templates/messages/show"]()
    @
)
