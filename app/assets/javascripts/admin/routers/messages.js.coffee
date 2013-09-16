Augury.Routers.Messages = Backbone.Router.extend(
  routes:
    "messages": "index"
    "messages/:id": "show"

  index: ->
    view = new Augury.Views.Messages.Index
    $("#integration_main").html view.render().el

  show: (id) ->
    message = new Augury.Models.Message(id: id)
    message.fetch()
    view = new Augury.Views.Messages.Show(model: message)
    $("#integration_main").html view.render().el
)
