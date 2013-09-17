Augury.Views.Messages.Index = Backbone.View.extend(
  render: ->
    @$el.html JST["admin/templates/messages/index"]()

    @$el.find('#messages-queue').before new Augury.Views.Queues.Stats().render().el

    @
)

