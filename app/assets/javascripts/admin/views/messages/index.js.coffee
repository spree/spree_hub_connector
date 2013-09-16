Augury.Views.Messages.Index = Backbone.View.extend(
  render: ->
    @$el.html JST["admin/templates/messages/index"]()
    @
)

